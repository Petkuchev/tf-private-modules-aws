resource "aws_cloudwatch_log_group" "redis" {
  name = "Redis_${var.group_id}"

  retention_in_days = var.log_retention
}