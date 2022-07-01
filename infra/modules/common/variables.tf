# ----------------------------------------------------------------------
# DNS CONFIG
# ----------------------------------------------------------------------
variable "dns_zone_name" {
    description = "Name of the DNS zone."
    type        = string
}

variable "dns_name" {
    description = "DNS name of the zone, e.g. example.com"
    type        = string
}

variable "dns_visibility" {
   description = "The zone's visibility." 
   type        = string
   default     = "public"
}

variable "dns_labels" {
    description = "Labels to attach to the zone."
    type = map(string)
}


# ----------------------------------------------------------------------
# KEY RING CONFIG
# ----------------------------------------------------------------------
variable "key_ring_name" {
    description = "Name of the key ring"
    type        = string
}

variable "key_ring_location" {
    description = "Location of the key ring"
    type        = string
}

# ----------------------------------------------------------------------
# GCR CONFIG
# ----------------------------------------------------------------------
variable "gcr_name" {
    description = "Name of the Google Container Registry"
    type        = string
}

variable "gcr_location" {
    description = "Location of the Google Container Registry"
    type        = string
}

# ----------------------------------------------------------------------
# GKE CONFIG
# ----------------------------------------------------------------------
variable "project_id" {
    description = "ID of the project to create the GKE Cluster in."
    type        = string
}
variable "gke_name" {
    description = "Name of the GKE Cluster"
    type        = string
}

variable "gke_location" {
    description = "Location of the GKE Cluster"
    type        = string
}

variable "gke_primary_nodepool_name" {
    description = "Name of the primary nodepool"
    type        = string
    default     = "primary-preemptible-nodepool"
}

variable "gke_primary_nodepool_count" {
    description = "Number of nodes in the primary pool"
    type        = number
    default     = 3
}

variable "gke_primary_nodepool_machine_type" {
    description = "Machine type of nodes in the primary pool."
    type        = string
    default     = "e2-standard-2"
}
