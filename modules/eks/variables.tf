## The variables in this file are ordered alphabetically
variable "cluster_enabled_log_types" {
  type = list(string)
}
variable "alb_controller" {
  type = object(
    {
      role_enabled = bool
      version      = optional(string)
    }
  )
  # validation {
  #   condition     = var.alb_controller.role_enabled == true && ( var.alb_controller.version != null || var.alb_controller.version != "" )
  #   error_message = "If alb_controller role_enabled is true, you have to pass the version"
  # }
  description = "Deploy the version of the AWS Load Balancer controller service in the cluster"
  default = {
    role_enabled = false
  }
}

variable "aws_auth_roles" {
  type = list(object(
    {
      rolearn  = string
      username = string
      groups   = list(string)
    }
  ))
  description = "List of roles that will be added to the Kubernetes aws-auth ConfigMap"
  default     = []
}

variable "aws_auth_users" {
  type = list(object(
    {
      userarn  = string
      username = string
      groups   = list(string)
    }
  ))
  description = "List of users that will be added to the Kubernetes aws-auth ConfigMap"
  default     = []
}

variable "cluster_name" {
  type        = string
  description = "The name of the EKS cluster"
}

variable "cluster_security_group_additional_rules" {
  type = map(object(
    {
      cidr_blocks              = optional(list(string))
      description              = optional(string)
      from_port                = number
      to_port                  = number
      ipv6_cidr_blocks         = optional(list(string))
      protocol                 = string
      self                     = optional(bool)
      source_security_group_id = optional(string)
      type                     = string
    }
  ))
  description = "List of additional Security Group rules to be added to the EKS cluster Security Group"
  default     = {}
}

variable "cluster_service_ipv4_cidr" {
  type        = string
  description = "CIDR IP Block that will be used for the services in the EKS cluster"
  default     = "10.100.0.0/16"
}

variable "cluster_version" {
  type        = string
  description = "The version of the EKS cluster"
  default     = "1.24"
}

variable "create_aws_auth_configmap" {
  type        = bool
  description = "Determines whether to create the aws-auth configmap. Only enable it if aws-auth configmap does not exist and when using self-managed node groups"
  default     = false
}

variable "ebs_cni_role_enabled" {
  type        = bool
  description = "Enable the creation of the AWS Role for the EBS CNI Kubernetes service"
  default     = false
}

variable "ecr_registries" {
  type        = map(string)
  description = "Map of aws_region = account_id pairs used for giving the NodeGroups the permissions to Push/Pull from the ECR Registries"
  default     = {}
}

variable "external_dns_role_enabled" {
  type        = bool
  description = "Enable the creation of the AWS Role for the external DNS Kubernetes service"
  default     = false
}

variable "genesis_s3_bucket_name" {
  type        = string
  description = "S3 bucket name where the genesis.json file is"
}

variable "iam_node_role_additional_policies" {
  type = map(object(
    {
      description = string
      policy_body = any
    }
  ))
  description = "Map of policies that will be added to the EKS node groups. The policy_body should contain a JSON like the 'policy' section of any 'aws_iam_policy' resource"
  default     = {}
}

variable "manage_aws_auth_configmap" {
  type        = bool
  description = "Determines whether to manage the aws-auth configmap. This variable has to be set to false initialy, once the cluster is created, change it to true and apply the code again."
  default     = false
}

variable "node_groups" {
  type = map(object(
    {
      name            = string
      instance_types  = list(string)
      ami_type        = string
      capacity_type   = string
      disk_size       = number
      key_name        = string
      min_size        = number
      desired_size    = number
      max_size        = number
      labels          = map(string)
      use_name_prefix = bool
    }
  ))
  description = "Map of objects that contain values for the EKS node groups"
}

variable "node_groups_user_data" {
  type        = map(string)
  description = "user_data script per node_group with the format node_group name => user_data script content"
  default     = {}
}

variable "node_security_group_additional_rules" {
  type        = any
  description = "Map of objects that will be used to create additional rules for the AWS Security group of the EKS cluster node groups"
  default     = {}
}

# variable "node_security_group_additional_rules" {
#     type = map(object(
#       {
#         description = string
#         policy      = string
#       }
#     ))
#     description = "Map of objects that will be used to create additional rules for the AWS Security group of the EKS cluster node groups"
#     default     = {}
# }

variable "cluster_identity_providers" {
  type = map(object(
    {
      name                          = string # This name has to match with the key in the map. This can only be 'oidc' for now need to change
      client_id                     = string
      identity_provider_config_name = string
      issuer_url                    = string
      username_claim                = string
      username_prefix               = optional(string)
      groups_prefix                 = optional(string)
      required_claims               = optional(map(string))
      groups_claim                  = string
      AzureGroupID                  = string
    }
  ))
  description = "Map of values to configure the EKS cluster identity provider. The key of the map has to match the 'name' variable in each object"
  default     = {}
}

variable "private_subnets" {
  type        = list(string)
  description = "The private subnet IDs that the EKS cluster and the node groups will use"
}

variable "qredochain_role_enabled" {
  type        = bool
  description = "Enable the creation of the AWS Role for the Qredochain Kubernetes service"
  default     = false
}

variable "tags" {
  type        = map(string)
  description = "List of tags added to all the resources created"
  default = {
    terraform = true
  }
}

variable "vpc_id" {
  type        = string
  description = "The VPC ID where the resources will be created"
}

variable "cloudwatch_log_group_retention_in_days" {
  description = "Number of days to retain log events. Default retention - 90 days"
  type        = number
  default     = 90
}

variable "kms_key_administrators" {
  description = "A list of IAM ARNs for [key administrators](https://docs.aws.amazon.com/kms/latest/developerguide/key-policy-default.html#key-policy-default-allow-administrators). If no value is provided, the current caller identity is used to ensure at least one key admin is available"
  type        = list(string)
  default     = []
}
