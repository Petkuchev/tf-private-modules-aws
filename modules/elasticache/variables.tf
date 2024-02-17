variable "failover" {
  type        = bool
  default     = "true"
  description = "Optional. Enable failover. True by default"
}

variable "replicas_per_node_group" {
  type        = number
  description = "Required. Select the number of replica for the node group."
}

variable "snapshot_retention" {
  type        = number
  default     = 3
  description = "Optional. The number of days AWS will store a snapshot before it's retained."
}

variable "num_node_groups" {
  type        = number
  default     = 1
  description = "Optional.The number of node groups."
}

variable "group_id" {
  type        = string
  description = "Redis group ID. Moreover, used for naming of some resources like logs and buckets"
}

variable "description" {
  type        = string
  default     = "Redis Cluster Production"
  description = "Optional. Redis description."
}

variable "node_type" {
  type        = string
  description = "Required. Node type for Redis. Supported types - https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/CacheNodes.SupportedTypes.html"
}

variable "num_cache_clusters" {
  type        = number
  default     = 3
  description = "Optional. Number of cache cluster."
}

variable "parameter_group_name" {
  type        = string
  default     = "default.redis7"
  description = "Optional. Group name. By default - default.redis7."
}

variable "port" {
  type        = number
  default     = 6379
  description = "Optional. Redis port."
}

variable "multi_az_enabled" {
  type        = bool
  default     = true
  description = "Optional. Multi AZ enabled by default."
}

variable "vpc_id" {
  type        = string
  description = "Required. Define the VPC in which redis will be deployed."
}

variable "subnet_ids" {
  type        = list(string)
  description = "Required. Define subnets ids of the VPC."
}

variable "tansit_encryption" {
  type        = bool
  default     = true
  description = "Optional. Data in transit encryption. Enabled by default"
}

variable "ingress_cidr" {
  type        = list(string)
  description = "Required. Specify ingress rule for Redis security group."
}

variable "egress_cidr" {
  type        = list(string)
  default     = ["0.0.0.0/0"]
  description = "Optional. Specify egress rule for Redis security group."
}

variable "log_retention" {
  type        = number
  default     = 180
  description = "Optional. Log data retention. 180 days (6 months) by default"
}

variable "kms_alias" {
  type        = string
  default     = "alias/redis"
  description = "KMS Alias"
}

variable "enable_key_rotation" {
  type = bool
  default = false
  description = "Specifies whether key rotation is enabled. Defaults to false."
}

variable "at_rest_encryption_enabled" {
  type = bool
  default = true
  description = "Enable at rest encryption. True by default."
}

