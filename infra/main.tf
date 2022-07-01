# ----------------------------------------------------------------------------------------------------
# PROVIDERS
# ----------------------------------------------------------------------------------------------------
terraform {
  backend "gcs" {
    bucket = "mindman-tf-state"
    prefix = "eleutherios/state"
  }
}

provider "google-beta" {
  project = var.gcp_project_id
  region  = var.gcp_region
  zone    = var.gcp_zone
}

provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
  zone    = var.gcp_zone
}

# ----------------------------------------------------------------------------------------------------
# COMMON INFRASTRUCTURE
# Deploy the common infrastrucure for the project, DNS Zones, keyrings, etc.
# Common infrastructure should be pretty minimal.
# ----------------------------------------------------------------------------------------------------
module "common_infrastructure" {
  source = "./modules/common"

  dns_zone_name = "${var.project_name}-zone"
  dns_name      = "${var.project_name}.io."
  dns_labels    = { "usage" = "toplevel" }

  gcr_name     = var.project_name
  gcr_location = var.gcp_region

  project_id   = var.gcp_project_id
  gke_name     = var.project_name
  gke_location = var.gcp_zone           # force cluster to be zonal

  gke_primary_nodepool_count = 3
}
