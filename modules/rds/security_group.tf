resource "aws_security_group" "rds" {
  name        = "RDS-${var.db_name}-${var.environment}"
  description = "RDS-${var.db_name}-${var.environment}"
  vpc_id      = var.vpc

  lifecycle {
    create_before_destroy = true
  }
  tags = {
    name        = var.db_name
    terraform   = "true"
    environment = var.environment
    repo        = var.tf_git_repo
  }
}

resource "aws_security_group_rule" "ingress_rules" {
  count = length(var.ingress_rules)

  type              = "ingress"
  from_port         = var.ingress_rules[count.index].from_port
  to_port           = var.ingress_rules[count.index].to_port
  protocol          = var.ingress_rules[count.index].protocol
  cidr_blocks       = [var.ingress_rules[count.index].cidr_block]
  description       = var.ingress_rules[count.index].description
  security_group_id = aws_security_group.rds.id
}

resource "aws_security_group_rule" "egress_rules" {
  type              = "egress"
  from_port         = "0"
  to_port           = "0"
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow ALL"
  security_group_id = aws_security_group.rds.id
}
