resource "aws_elasticache_replication_group" "this" {
  automatic_failover_enabled = var.failover
  replication_group_id       = var.group_id
  description                = var.description
  node_type                  = var.node_type
  parameter_group_name       = var.parameter_group_name
  port                       = var.port
  multi_az_enabled           = var.multi_az_enabled
  subnet_group_name          = aws_elasticache_subnet_group.this.name
  security_group_ids         = [aws_security_group.redis.id]
  transit_encryption_enabled = var.tansit_encryption
  at_rest_encryption_enabled = var.at_rest_encryption_enabled
  kms_key_id                 = aws_kms_key.redis.arn
  replicas_per_node_group    = var.replicas_per_node_group
  num_node_groups            = var.num_node_groups
  snapshot_retention_limit   = var.snapshot_retention


  log_delivery_configuration {
    destination      = aws_cloudwatch_log_group.redis.name
    destination_type = "cloudwatch-logs"
    log_format       = "text"
    log_type         = "slow-log"
  }
}