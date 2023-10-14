resource "aws_security_group" "allow_rds" {
  name        = "rds-proxy"
  vpc_id      = var.vpc_id
  description = "Allow RDS Proxy connection to 5432"
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_security_group_rule" "ingress_rds" {
  for_each          = toset(var.allowed_ingress_cidr_blocks)
  type              = "ingress"
  from_port         = 5432
  to_port           = 5432
  protocol          = "tcp"
  cidr_blocks       = [each.value]
  security_group_id = aws_security_group.allow_rds.id
}