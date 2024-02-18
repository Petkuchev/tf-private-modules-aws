module "redis" {
  source                  = "../../modules/elasticache"
  group_id                = var.group_id
  ingress_cidr            = var.ingress_cidr
  node_type               = var.node_type
  subnet_ids              = var.subnet_ids
  replicas_per_node_group = var.replicas_per_node_group
  vpc_id                  = var.vpc_id
  multi_az_enabled        = var.multi_az_enabled
}