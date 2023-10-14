module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.16"

  name        = var.name
  description = "Security group for the OpenVPN Connector, with the needed ports opened"
  vpc_id      = var.vpc_id

  ingress_with_cidr_blocks = [
    {
        from_port   = 0
        to_port     = 0
        protocol    = -1
        cidr_blocks = "0.0.0.0/0"
        description = "Allow traffic from everywhere"
    }
  ]

  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = -1
      description = "Allow outbound traffic"
    }
  ]

  tags = var.tags
}