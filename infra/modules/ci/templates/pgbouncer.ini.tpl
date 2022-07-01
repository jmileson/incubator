[databases]
${database_name}= host=${database_host} port=${database_port} auth_user=${database_username} dbname=${database_name}

[pgbouncer]
listen_addr = 0.0.0.0
listen_port = 5432
unix_socket_dir =
auth_file = /etc/pgbouncer/userlist.txt
auth_type = plain
pool_mode = transaction
max_client_conn = ${max_client_conn}
default_pool_size = ${default_pool_size}
ignore_startup_parameters = extra_float_digits
# for debugging uncomment below.
# verbose = 2

# Log settings
admin_users = postgres
