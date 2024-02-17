resource "aws_elasticache_subnet_group" "this" {
  name       = "tf-redis-subnet-group"
  subnet_ids = var.subnet_ids
}