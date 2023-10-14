output "rds-proxy-endpoint" {
  value = aws_db_proxy.rds-proxy.endpoint
}

output "proxy-target-group" {
  value = aws_db_proxy_target.target.db_cluster_identifier
}

output "ingress_rules" {
  value = aws_security_group.allow_rds.ingress
}

output "secret-arn" {
  value = aws_secretsmanager_secret.rds-proxy.arn
}

output "proxy-role" {
  value = aws_iam_role.rds-proxy.arn
}

output "secret-recovery-window" {
  value = aws_secretsmanager_secret.rds-proxy.recovery_window_in_days
}

output "proxy-settings" {
  value = aws_db_proxy.rds-proxy.auth
}