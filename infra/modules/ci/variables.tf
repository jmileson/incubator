variable "gcp_project_id" {
    description = "ID of the GCP project."
    type        = string
}

# -----------------------------------------------------------------------------------
# SQL DATABASE VARIABLES
# -----------------------------------------------------------------------------------
variable "ci_sql_instance_name"  {
    description = "Name of the database instance for the Concourse server."
    type        = string
}

variable "ci_sql_region" {
    description = "Region where the database instance for the Concourse server is located."
    type        = string
}

variable "ci_sql_instance_tier" {
    description = "Tier of the database instance."
    type        = string
    default     = "db-f1-micro"
}

variable "ci_sql_instance_storage_size" {
    description = "Size of the storage disk for the database instance."
    type        = number
    default     = 100
}

variable "ci_database_name" {
    description = "Name of the database in the instance."
    type        = string
}

variable "ci_sql_user_name" {
    description = "Name of the user for the Concourse server."
    type        = string
}

variable "ci_sql_user_password" {
    description = "Password of the user for the Concourse server."
    type        = string
}

# -----------------------------------------------------------------------------------
# CONCOURSE VARIABLES
# -----------------------------------------------------------------------------------
variable "gke_cluster_endpoint" {
    description = "URL for the GKE cluster"
    type        = string
}

variable "gke_cluster_ca_certificate" {
    description = "CA Certificate for the GKE cluster."
    type        = string
}
variable "gke_auth_token" {
    description = "Token for authorizing GKE cluster access."
    type        = string
}

variable "concourse_admin_password" {
    description = "Password for admin Concourse user."
    type        = string
}

variable "dns_name" {
    description = "Name of the DNS domain."
    type        = string
}

variable "dns_zone_name" {
    description = "Name of the DNS zone."
    type        = string
}
