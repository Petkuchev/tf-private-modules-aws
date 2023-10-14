output "cluster_endpoint" {
  value       = module.eks.cluster_endpoint
  description = "Return Eks cluster endpoint."
}

output "cluster_certificate_authority_data" {
  sensitive   = true
  value       = module.eks.cluster_certificate_authority_data
  description = "Return Eks cluster certificate data to communicate with the cluster."
}

output "cluster_arn" {
  value       = module.eks.cluster_arn
  description = "Return Eks cluster arn."
}