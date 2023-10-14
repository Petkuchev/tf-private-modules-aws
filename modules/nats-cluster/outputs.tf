output "cluster_ports" {
  value = {
    clients_port = {
      port        = "4222"
      description = "Communication port between clients and NATS"
      accessible_from = var.client_cidr_blocks
    },
    monitoring_port = {
      port        = "8222"
      description = "Port used to access to the monitoring UI of NATS}"
      accessible_from = var.vpn_cidr_blocks
    },
    cluster_port = {
      port        = "6222"
      description = "Internal communication between NATS cluster servers. Accessible from cidr_blocks"
      accessible_from = [for subnet in data.aws_subnet.subnets : subnet.cidr_block]
    }
  }
}

output "load_balancer_dns_name" {
  value = aws_lb.nlb.dns_name
}