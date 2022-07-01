output "ci_sql_instance_name" {
    description = "Name of the database instance."
    value       = var.ci_sql_instance_name
}

output "ci_sql_user_password" {
    description = "Password of the user for the Concourse server."
    value       = var.ci_sql_user_password
}
