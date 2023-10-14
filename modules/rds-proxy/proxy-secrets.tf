# Secret https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret
resource "aws_secretsmanager_secret" "rds-proxy" {
  name                    = var.secrets_settings.name
  description             = var.secrets_settings.description
  recovery_window_in_days = var.secrets_settings.recovery_window_in_days
}

# RDS Proxy https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_proxy
resource "aws_db_proxy" "rds-proxy" {
  name                   = var.proxy_settings.name
  debug_logging          = var.proxy_settings.debug_logging
  engine_family          = var.proxy_settings.engine_family
  idle_client_timeout    = var.proxy_settings.idle_client_timeout
  require_tls            = var.proxy_settings.require_tls
  role_arn               = aws_iam_role.rds-proxy.arn
  vpc_security_group_ids = [aws_security_group.allow_rds.id]
  vpc_subnet_ids         = var.proxy_settings.vpc_subnet_ids


  auth {
    auth_scheme               = var.proxy_auth_settings.auth_scheme
    description               = var.proxy_auth_settings.description
    iam_auth                  = var.proxy_auth_settings.iam_auth
    client_password_auth_type = var.proxy_auth_settings.client_password_auth_type
    secret_arn                = aws_secretsmanager_secret.rds-proxy.arn
  }
}


resource "time_sleep" "create_60_seconds" {
  create_duration = "60s"
}

resource "time_sleep" "destroy_60_seconds" {
  destroy_duration = "60s"
}
# Target group
resource "aws_db_proxy_default_target_group" "target-group" {
  db_proxy_name = var.proxy_settings.name
  depends_on    = [time_sleep.create_60_seconds]
  connection_pool_config {
    connection_borrow_timeout    = var.connection_pool_config.connection_borrow_timeout
    max_connections_percent      = var.connection_pool_config.max_connections_percent
    max_idle_connections_percent = var.connection_pool_config.max_idle_connections_percent
  }
}

resource "aws_db_proxy_target" "target" {
  db_cluster_identifier = var.db_cluster_identifier
  db_proxy_name         = var.proxy_settings.name
  target_group_name     = aws_db_proxy_default_target_group.target-group.name
  depends_on            = [time_sleep.destroy_60_seconds]
}

resource "aws_db_proxy_endpoint" "read_only_endpoint" {
  db_proxy_name          = var.proxy_settings.name
  db_proxy_endpoint_name = aws_db_proxy.rds-proxy.name
  vpc_subnet_ids         = var.proxy_settings.vpc_subnet_ids
  target_role            = "READ_ONLY"
}