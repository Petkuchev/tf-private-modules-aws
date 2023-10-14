variable "ami" {
  description = "AWS AMI used for the NATS cluster instances"
  type        = string
  nullable    = false
}

variable "client_cidr_blocks" {
  description = "List of CIDR blocks that will access to the NATS cluster as clients"
  type        = list(string)
  nullable    = false
}

variable "cluster_size" {
  description = "The desired size for the NATS cluster"
  type        = number
  default     = 3

  validation {
    condition     = (var.cluster_size % 2) != 0
    error_message = "There is no point on having an odd number of servers in a cluster"
  }
}

variable "instance_type" {
  description = "AWS Instance type used for the NATS cluster instances"
  type        = string
  default     = "t2.micro"
}

variable "key_pair_name" {
  description = "AWS Key pair name used for the NATS cluster instances"
  type        = string
  nullable    = false
}

variable "key_pair_value" {
  description = "AWS Key pair value used for the NATS cluster instances"
  type        = string
  default     = null
  sensitive   = true
}

variable "name_prefix" {
  description = "Prefix for the NATS cluster resources. Ex: nats-cluster-1, nats-cluster-nlb, etc. Where the prefix is 'nats-cluster'"
  type        = string
  default     = "nats-cluster"
}

variable "nats_cert" {
  description = "NATS cluster private certificate value"
  type        = string
  nullable    = false
  sensitive   = true
}

variable "nats_key" {
  description = "NATS cluster private key value"
  type        = string
  nullable    = false
  sensitive   = true
}

variable "nats_key_passphrase" {
  description = "NATS cluster private key passphrase value"
  type        = string
  sensitive   = true
}

variable "root_ca" {
  description = "NATS cluster rootCA certificate value"
  type        = string
  nullable    = false
  sensitive   = true
}

variable "subnet_ids" {
  description = "List of AWS Subnet ids where the NATS cluster servers will be located"
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
  description = "AWS VPC id where the NATS cluster servers will be located"
  type        = string
  nullable    = false
}