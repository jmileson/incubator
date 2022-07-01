output "name_server_ips" {
    description = "IP Addresses of the DNS Name Servers"
    value       = google_dns_managed_zone.dns_zone.name_servers
}

output "node_pool_name" {
    description = "Name of the node pool"
    value       = var.gke_primary_nodepool_name
}

output "node_pool_zone" {
    description = "Zone the node pool is in."
    value       = var.gke_location

}

output "gke_name" {
    description = "Name of the GKE cluster."
    value       = var.gke_name
}

output "gke_cluster_endpoint" {
    description = "URL of the GKE Cluster."
    value       = "https://${google_container_cluster.gke.endpoint}"
}

output "gke_cluster_ca_certificate" {
    description = "CA Certificate for the GKE cluster."
    value       = base64decode(google_container_cluster.gke.master_auth.0.cluster_ca_certificate)
}
