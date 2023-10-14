variable "vpc_id" {
  type        = string
  description = "Opensearch VPC"
}

variable "es_version" {
  type        = string
  description = "Elastichsearch version"
  default     = "OpenSearch_2.7"
}

variable "domain" {
  type        = string
  description = "Opensearch domain"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnet IDs"
}

variable "instance_count" {
  type        = number
  description = "Even number for the Elasticsearch nodes"
}

variable "instance_type" {
  type        = string
  description = "Instance type for the Elasticsearch nodes"
}

variable "volume_size" {
  type        = number
  description = "Size of node disk"
}

variable "volume_type" {
  type        = string
  description = "Type of volume"
}

variable "master_user_name" {
  type        = string
  description = "Master username"
}

variable "master_user_password" {
  type        = string
  description = "Master user password, use TF_VAR_master_user_password"
}

variable "region" {
  type        = string
  description = "AWS Region"
}
