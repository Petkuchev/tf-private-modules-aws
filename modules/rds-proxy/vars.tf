variable "region" {
  type        = string
  default     = "eu-west-1"
  description = "AWS Region"
}

variable "access_key" {
  type    = string
  default = "Not Set"
}

variable "secret_key" {
  type    = string
  default = "Not Set"
}

variable "secret_values" {
  sensitive = true
  default = {
    username = "postgres"
    password = "mystrongpassword"
  }

  type = map(string)
}

variable "secrets_settings" {
  type = object({
    name                    = string
    description             = string
    recovery_window_in_days = number
  })
}

variable "proxy_settings" {
  type = object({
    name                = string
    debug_logging       = bool
    engine_family       = string
    idle_client_timeout = number
    require_tls         = bool
    vpc_subnet_ids      = list(string)
  })
}

variable "iam_settings" {
  type = object({
    policy_name        = string
    policy_description = string
    role_name          = string
  })
}

variable "db_cluster_identifier" {
  type        = string
  description = "RDS Cluster name"
}

variable "proxy_auth_settings" {
  type = object({
    auth_scheme               = string
    description               = string
    iam_auth                  = string
    client_password_auth_type = string
  })
}

variable "allowed_ingress_cidr_blocks" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}

variable "connection_pool_config" {
  type = object({
    connection_borrow_timeout    = number
    max_connections_percent      = number
    max_idle_connections_percent = number
  })
}