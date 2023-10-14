resource "random_id" "s3" {
  byte_length = 8
}

resource "aws_s3_bucket" "redis_logs" {
  bucket        = "redis-logs-data-${var.group_id}-${random_id.s3.hex}"
  force_destroy = true
}