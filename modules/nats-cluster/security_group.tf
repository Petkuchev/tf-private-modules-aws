locals {
  ingress_cidr_blocks = [for subnet in data.aws_subnet.subnets : subnet.cidr_block]
  vpn_cidr_blocks     = join(",", var.vpn_cidr_blocks)
  client_cidr_blocks  = join(",", var.client_cidr_blocks)
}

module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.16"

  name        = var.name_prefix
  description = "Security group for the NATS cluster, with the needed ports opened"
  vpc_id      = var.vpc_id

  ingress_cidr_blocks = local.ingress_cidr_blocks

  ingress_with_cidr_blocks = [
    {
        from_port   = 6222
        to_port     = 6222
        protocol    = "TCP"
        description = "Internal communication between NATS cluster servers"
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "TCP"
      description = "SSH port from VPN"
      cidr_blocks = local.vpn_cidr_blocks
    },
    {
      from_port   = 8222
      to_port     = 8222
      protocol    = "TCP"
      description = "Load balancer health check"
    },
    {
      from_port   = 8222
      to_port     = 8222
      protocol    = "TCP"
      description = "Monitoring from VPN"
      cidr_blocks = local.vpn_cidr_blocks
    },
    {
      from_port   = 4222
      to_port     = 4222
      protocol    = "TCP"
      description = "Client communication to NATS"
      cidr_blocks = local.client_cidr_blocks
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