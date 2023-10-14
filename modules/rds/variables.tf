variable "db_name" {
  description = "Database Name"
  type        = string
}

variable "db_username" {
  description = "RDS root user"
  type        = string
}

variable "db_password" {
  description = "RDS root password"
  type        = string
}

variable "db_type" {
  description = "RDS type password"
  type        = string
}

variable "db_type_version" {
  description = "RDS type password"
  type        = string
}

variable "environment" {
  description = "Environment where resources are deployed"
  type        = string
  nullable    = false
}

variable "tf_git_repo" {
  description = "repo url where you store the TF"
  type        = string
  nullable    = false
}

variable "vpc" {
  description = "VPC"
  type        = string
}

variable "region" {
  type = any
}

variable "subnet_ids" {
  type = any
}

variable "volume_size" {
  type = any
}

variable "ingress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_block  = string
    description = string
  }))
}

variable "parameter_group" {
  description = "List of parameters"
  type = list(object({
    name         = string
    value        = string
    apply_method = string
  }))
}

variable "db_instance" {
  type = any
}

variable "db_apply_immediately" {
  type        = bool
  default     = false
  description = "Apply configuration changes immediately(true) or wait till next maintenance window(false)"
}

variable "enable_multi_az" {
  type    = bool
  default = false
}

variable "ca_cert_identifier" {
  type = string
}

variable "storage_encrypted" {
  type    = bool
  default = false
}