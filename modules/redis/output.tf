output "redis_endpoint" {
  value       = aws_elasticache_replication_group.this.primary_endpoint_address
  description = "Return Redis primary endpoint."
}

output "availability_zones" {
  value       = aws_elasticache_replication_group.this.availability_zones
  description = "Availability zones"
}

output "rest_encryption" {
  value       = aws_elasticache_replication_group.this.at_rest_encryption_enabled
  description = "At rest encryption status"
}

output "reader_endpoint_address" {
  value       = aws_elasticache_replication_group.this.reader_endpoint_address
  description = "Reader endpoint address"
}

output "transit_encryption" {
  value       = aws_elasticache_replication_group.this.transit_encryption_enabled
  description = "Transit encryption status"
}

output "kms_id" {
  value       = aws_kms_key.redis.id
  description = "Return kms key id"
}

output "s3_name" {
  value       = aws_s3_bucket.redis_logs.id
  description = "Return s3 id"
}

