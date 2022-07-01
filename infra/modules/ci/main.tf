# -----------------------------------------------------------------------------------
# SQL DATABASE CONFIG
# -----------------------------------------------------------------------------------
resource "google_sql_database_instance" "sql_instance" {
  name             = var.ci_sql_instance_name
  database_version = "POSTGRES_11"
  region           = var.ci_sql_region

  settings {
    # second-generation instance tiers are based on the machine type
    tier      = var.ci_sql_instance_tier

    disk_size = var.ci_sql_instance_storage_size
    disk_type = "PD_HDD"
  }

  timeouts {
    create = "15m"
    delete = "15m"
  }
}

resource "google_sql_database" "sql_database" {
  name     = var.ci_database_name
  instance = google_sql_database_instance.sql_instance.name
}

resource "google_sql_user" "users" {
  name     = var.ci_sql_user_name
  instance = google_sql_database_instance.sql_instance.name
  password = var.ci_sql_user_password
}

# -----------------------------------------------------------------------------------
# CONCOURSE CONFIG
# -----------------------------------------------------------------------------------
# see for more on this configuration https://medium.com/google-cloud/bootstrapping-google-kubernetes-engine-after-creating-it-dca595f830a1
provider "kubernetes" {
  # TODO don't run the common and ci modules in the same `apply` since
  # common might create this resource, and this is advised against
  # maybe pull this module up a level?
  # there's an issue when creating a cluster then using that
  # cluster as a provider
  version = "1.10.0"

  load_config_file = false

  host                   = var.gke_cluster_endpoint
  cluster_ca_certificate = var.gke_cluster_ca_certificate
  token                  = var.gke_auth_token
}

locals {
    namespace_name  = "ci-cd"
    name            = "web"
    image           = "concourse/concourse:5.5.8"

    secret_volume   = "/etc/ci-cd"

    pg_bouncer_name              = "pg-bouncer"
    pg_bouncer_default_pool_size = 20
    pg_bouncer_max_client_conn   = 100
    pg_bouncer_proxy_port        = 5433

    service_account_name = "concourse-sql-sa"

    subdomain_name = "concourse.${var.dns_name}"
}

#################################
# namespace for ci-cd resources #
#################################
resource "kubernetes_namespace" "ns" {
  metadata {
    name            = local.namespace_name

    labels = {
        "istio-injection" = "enabled"
    }
  }
}

#####################################
# service account for accessing sql #
#####################################
resource "google_service_account" "sql_service_account" {
  account_id   = local.service_account_name
  display_name = "Concourse SQL Service Account"
}

# enable workload identity for the service account
resource "google_service_account_iam_binding" "gsa_workload_identity" {
  service_account_id = google_service_account.sql_service_account.name
  role = "roles/iam.workloadIdentityUser"

  members = [
    "serviceAccount:${var.gcp_project_id}.svc.id.goog[${local.namespace_name}/${local.service_account_name}]"
  ]
}

resource "kubernetes_service_account" "sql_service_account" {
  metadata {
    name      = local.service_account_name
    namespace = local.namespace_name

    annotations = {
      "iam.gke.io/gcp-service-account" = "${local.service_account_name}@${var.gcp_project_id}.iam.gserviceaccount.com"
    }
  }
}

# enable sql client for the service account
resource "google_project_iam_binding" "gsa_sql_client" {
  project = var.gcp_project_id
  role    = "roles/cloudsql.client"

  members = [
    "serviceAccount:${google_service_account.sql_service_account.email}"
  ]
}

########################
# pgbouncer deployment #
########################
data "template_file" "pgbouncer_ini" {
  template = "${file("${path.module}/templates/pgbouncer.ini.tpl")}"

  vars = {
    database_name     = var.ci_database_name
    database_username = var.ci_sql_user_name
    database_host     = "localhost"
    database_port     = local.pg_bouncer_proxy_port
    max_client_conn   = local.pg_bouncer_max_client_conn
    default_pool_size = local.pg_bouncer_default_pool_size
  }
}

data "template_file" "userlist_txt" {
  template = "${file("${path.module}/templates/userlist.txt.tpl")}"

  vars = {
    database_username = "${var.ci_sql_user_name}"
    database_pass     = "${var.ci_sql_user_password}"
  }
}

resource "kubernetes_secret" "db_config_files" {
  metadata {
    name      = "db-config-files"
    namespace = local.namespace_name
  }
 
  data = {
    "pgbouncer.ini" = "${data.template_file.pgbouncer_ini.rendered}"
    "userlist.txt"  = "${data.template_file.userlist_txt.rendered}"
  }
}

resource "kubernetes_secret" "db" {
  metadata {
    name      = "db"
    namespace = local.namespace_name
  }
  
  data = {
    "postgres-connection-name" = google_sql_database_instance.sql_instance.connection_name

    "postgres-port"     = 5432
    "postgres-database" = var.ci_database_name
    "postgres-user"     = var.ci_sql_user_name
    "postgres-password" = var.ci_sql_user_password
  }
}

resource "kubernetes_deployment" "pg_bouncer" {
  metadata {
    name      = local.pg_bouncer_name
    namespace = local.namespace_name

    labels = {
        app = local.pg_bouncer_name
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = local.pg_bouncer_name
      }
    }

    template {
      metadata {
        labels = {
          app = local.pg_bouncer_name
        }
      }

      spec {
        service_account_name = local.service_account_name

        volume {
          name   = kubernetes_secret.db_config_files.metadata.0.name
          secret {
            secret_name = kubernetes_secret.db_config_files.metadata.0.name
          }
        }

        container {
          image = "gcr.io/cloudsql-docker/gce-proxy:1.16"
          name  = "cloud-sql-proxy"

          command = [
            "/cloud_sql_proxy",
            "-instances=$(INSTANCE_CONNECTION_NAME)=tcp:${local.pg_bouncer_proxy_port}",
          ]

          security_context {
            run_as_user                = 2
            allow_privilege_escalation = false
          }

          env {
            name       = "INSTANCE_CONNECTION_NAME"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.db.metadata.0.name
                key  = "postgres-connection-name"
              }
            }
          }
        }

        container {
          image = "edoburu/pgbouncer:1.11.0"
          name  = local.pg_bouncer_name
          
          port {
            container_port = 5432
            protocol       = "TCP"
          }

          liveness_probe {
            tcp_socket {
              port = 5432
            }
            period_seconds = 60
          }
          lifecycle {
            pre_stop {
              exec {
                # Allow existing queries clients to complete within 120 seconds
                command = ["/bin/sh", "-c", "killall -INT pgbouncer && sleep 120"]
              }
            }
          }
          security_context {
            run_as_user                = 2
            allow_privilege_escalation = false
            capabilities {
              drop = ["all"]
            }
          }

          volume_mount {
            name       = kubernetes_secret.db_config_files.metadata.0.name
            mount_path = "/etc/pgbouncer"
            read_only  = true
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "pg_bouncer_service" {
  depends_on = [
    kubernetes_deployment.pg_bouncer
  ]

  metadata {
    name      = local.pg_bouncer_name
    namespace = local.namespace_name
  }
  spec {
    selector = {
      app = local.pg_bouncer_name
    }
    session_affinity = "ClientIP"
    port {
      port        = kubernetes_secret.db.data["postgres-port"]
      target_port = kubernetes_secret.db.data["postgres-port"]
      protocol    = "TCP"
      name        = local.name
    }

    type = "ClusterIP"
  }
}

####################
# concourse config #
####################
resource "tls_private_key" "session_signing_key" {
  algorithm   = "RSA"
  rsa_bits    = 4096
}

resource "tls_private_key" "tsa_host_key" {
  algorithm   = "RSA"
  rsa_bits    = 4096
}

resource "tls_private_key" "worker_key" {
  algorithm   = "RSA"
  rsa_bits    = 4096
}

resource "kubernetes_secret" "keys" {
  metadata {
    name      = "keys"
    namespace = local.namespace_name
  }

  data = {
    "session-signing-key" = tls_private_key.session_signing_key.private_key_pem
    "tsa-host-key"        = tls_private_key.tsa_host_key.private_key_pem
    "tsa-host-public-key" = tls_private_key.tsa_host_key.public_key_openssh
    "worker-key"          = tls_private_key.worker_key.private_key_pem
    "worker-public-key"   = tls_private_key.worker_key.public_key_openssh
  }
}

resource "kubernetes_secret" "concourse_admin" {
  metadata {
    name = "concourse-user"
    namespace = local.namespace_name
  }

  data = {
    user = "admin:${var.concourse_admin_password}"
  }
}

# TODO set the redirect url for logins CONCOURSE_EXTERNAL_URL=http://blah.com
# TODO set CONCOURSE_X_FRAME_OPTIONS=deny
# TODO ingress for ci
# TODO dns entry for ingress
# TODO PV and PVC for `worker` CONCOURSE_WORK_DIR=/opt/concourse/worker
# TODO PV and PVC for `worker` bazel cache?
resource "kubernetes_deployment" "web" {
  depends_on = [
    kubernetes_service.pg_bouncer_service
  ]

  metadata {
    name      = local.name
    namespace = local.namespace_name

    labels = {
        app = local.name
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = local.name
      }
    }

    template {
      metadata {
        labels = {
          app = local.name
        }
      }

      spec {
        volume {
          name   = kubernetes_secret.keys.metadata.0.name
          secret {
            secret_name = kubernetes_secret.keys.metadata.0.name
          }
        }
        container {
          image = local.image
          name  = local.name
          command = [
            "dumb-init",
            "/usr/local/concourse/bin/concourse",
            "web"
          ]

          env {
            name  = "CONCOURSE_SESSION_SIGNING_KEY"
            value = "${local.secret_volume}/session-signing-key"
          }
          env {
            name  = "CONCOURSE_TSA_HOST_KEY"
            value = "${local.secret_volume}/tsa-host-key"
          }
          env {
            name  = "CONCOURSE_TSA_AUTHORIZED_KEYS"
            value = "${local.secret_volume}/worker-public-key"
          }
          env {
            name  = "CONCOURSE_POSTGRES_HOST"
            value = local.pg_bouncer_name
          }
          env {
            name       = "CONCOURSE_POSTGRES_PORT"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.db.metadata.0.name
                key  = "postgres-port"
              }
            }
          }
          env {
            name       = "CONCOURSE_POSTGRES_DATABASE"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.db.metadata.0.name
                key  = "postgres-database"
              }
            }
          }
          env {
            name       = "CONCOURSE_POSTGRES_USER"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.db.metadata.0.name
                key  = "postgres-user"
              }
            }
          }
          env {
            name       = "CONCOURSE_POSTGRES_PASSWORD"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.db.metadata.0.name
                key  = "postgres-password"
              }
            }
          }
          env {
            name  = "CONCOURSE_MAIN_TEAM_LOCAL_USER"
            value = "admin"
          }
          env {
            name = "CONCOURSE_ADD_LOCAL_USER"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.concourse_admin.metadata.0.name
                key  = "user"
              }
            }
          }
          env {
            name = "CONCOURSE_EXTERNAL_URL"
            value = "https://${local.subdomain_name}"
          }
          volume_mount {
            name       = kubernetes_secret.keys.metadata.0.name
            mount_path = local.secret_volume
            read_only  = true
          }
          resources {
            limits {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "web_service" {
  depends_on = [
    kubernetes_deployment.web
  ]

  metadata {
    name      = local.name
    namespace = local.namespace_name
  }
  spec {
    selector = {
      app = local.name
    }
    session_affinity = "ClientIP"
    port {
      port        = 8080
      protocol    = "TCP"
      name        = local.name
    }

    type = "ClusterIP"
  }
}
