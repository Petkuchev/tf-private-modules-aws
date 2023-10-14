variable "ami" {
  description = "AWS AMI used for the EC2 cluster instances"
  type        = string
  nullable    = false
}

variable "client_cidr_blocks" {
  description = "List of CIDR blocks that will access to the EC2 cluster as clients"
  type        = list(string)
  nullable    = false
}

variable "cluster_size" {
  description = "The desired size for the EC2 cluster"
  type        = number
  default     = 3

  validation {
    condition     = (var.cluster_size % 2) != 0
    error_message = "There is no point on having an odd number of servers in a cluster"
  }
}

variable "instance_type" {
  description = "AWS Instance type used for the EC2 cluster instances"
  type        = string
  default     = "t2.micro"
}

variable "key_pair_name" {
  description = "AWS Key pair name used for the EC2 cluster instances"
  type        = string
  nullable    = false
}

variable "key_pair_value" {
  description = "AWS Key pair value used for the EC2 cluster instances"
  type        = string
  default     = null
  sensitive   = true
}

variable "name_prefix" {
  description = "Prefix for the EC2 cluster resources. Ex: EC2-cluster-1, EC2-cluster-nlb, etc. Where the prefix is 'EC2-cluster'"
  type        = string
  default     = "EC2-cluster"
}

variable "subnet_ids" {
  description = "List of AWS Subnet ids where the EC2 cluster servers will be located"
  type        = list(string)
  nullable    = false

  validation {
    condition     = 0 < length(var.subnet_ids)
    error_message = "The list of AWS Subnet ids cannot be empty"
  }
}

variable "tags" {
  type        = map(string)
  description = "List of tags added to all the resources created"
  default = {
    Terraform = true
  }
}

variable "vpn_cidr_blocks" {
  description = "List of VPN CIDR blocs"
  type        = list(string)
  default     = ["100.96.0.0/16"]
}

variable "vpc_id" {
  description = "AWS VPC id where the EC2 cluster servers will be located"
  type        = string
  nullable    = false
}

variable "instance_count" {
  description = "The number of EC2 instances to create"
  type        = number
  default     = 1
}