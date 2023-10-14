output "instance_ids" {
  description = "The IDs of the created EC2 instances"
  value       = module.ec2_instance[*].id
}

output "public_ips" {
  description = "The public IPs of the created EC2 instances"
  value       = module.ec2_instance[*].public_ip
}

output "private_ips" {
  description = "The private IPs of the created EC2 instances"
  value       = module.ec2_instance[*].private_ip
}
