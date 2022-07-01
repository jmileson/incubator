# ----------------------------------------------------------------------
# DNS CONFIG
# ----------------------------------------------------------------------
resource "google_dns_managed_zone" "dns_zone" {
    name         = var.dns_zone_name
    dns_name     = var.dns_name
    visibility   = var.dns_visibility
    labels       = var.dns_labels
}

# ----------------------------------------------------------------------
# GCR CONFIG
# ----------------------------------------------------------------------
resource "google_storage_bucket" "container_registry_bucket" {
  name     = var.gcr_name
  location = "US"
}

# ----------------------------------------------------------------------
# GKE CONFIG
# ----------------------------------------------------------------------
resource "google_container_cluster" "gke" {
  provider = google-beta

  name     = var.gke_name
  location = var.gke_location

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1

  addons_config {
    horizontal_pod_autoscaling {
      disabled = true
    }
  }
    
  # allow maintenance to occur after 2:00 AM
  maintenance_policy {
    daily_maintenance_window {
      start_time = "03:00"
    }
  }

  # allow workload identity
  workload_identity_config {
    identity_namespace = "${var.project_id}.svc.id.goog"
  }

  # disable basic auth to master
  master_auth {
    username = ""
    password = ""

    client_certificate_config {
      issue_client_certificate = false
    }
  }

  timeouts {
    create = "15m"
    delete = "15m"
  }
}

resource "google_container_node_pool" "primary_nodepool" {
  name       = var.gke_primary_nodepool_name
  location   = var.gke_location
  cluster    = google_container_cluster.gke.name
  node_count = var.gke_primary_nodepool_count

  node_config {
    preemptible  = true
    machine_type = var.gke_primary_nodepool_machine_type

    metadata = {
      disable-legacy-endpoints = "true"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
  
  management {
    auto_repair  = true
    auto_upgrade = true
  }

  timeouts {
    create = "15m"
    delete = "15m"
  }
}
