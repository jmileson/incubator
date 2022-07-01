variable "project_name" {
  description = "Name of the project."
  type        = string
}

variable "gcp_project_id" {
  description = "The name of the GCP project to launch resources in."
  type        = string
}

variable "gcp_region" {
  description = "The region where GCP resources are launced."
  type        = string
}

variable "gcp_zone" {
  description = "The zone where GCP resources are launched."
  type        = string
}

variable "ci_sql_user_password" {
  description = "Password of the user for the Concourse server."
  type        = string
}

variable "concourse_admin_password" {
  description = "Password for admin Concourse user."
  type        = string
}
