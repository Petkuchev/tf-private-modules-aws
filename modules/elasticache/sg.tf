resource "aws_security_group" "redis" {
  name        = "redis_security_group"
  description = "Allow Redis connections from external services"
  vpc_id      = var.vpc_id

  ingress {
    description = "K8S to Redis"
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = var.ingress_cidr
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.egress_cidr
  }
}