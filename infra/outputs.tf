output "name_server_ips" {
  description = "IP Addresses of the DNS Name Servers"
  value       = module.common_infrastructure.name_server_ips
}

output "node_pool_name" {
  description = "Name of the node pool"
  value       = module.common_infrastructure.node_pool_name
}

output "node_pool_zone" {
  description = "Zone the node pool is in."
  value       = module.common_infrastructure.node_pool_zone

}

output "gke_name" {
  description = "Name of the GKE cluster."
  value       = module.common_infrastructure.gke_name
}

output "ci_sql_instance_name" {
  description = "Name of the database instance."
  value       = module.ci_cd.ci_sql_instance_name
}

output "ci_sql_user_password" {
  description = "Password of the user for the Concourse server."
  value       = module.ci_cd.ci_sql_user_password
  sensitive   = true
}
