variable "account_id" {
  description = "Cloudflare account ID"
  type        = string
  sensitive   = true
  default     = "d993714d2eb6a13c474f3222f6c934d3"
}

variable "access_application" {
  type        = bool
  description = "Wether to create a access app"
  default     = false
}

variable "access_policy" {
  type        = bool
  description = "Wether to create a access policy"
  default     = false
}

variable "project_name" {
  description = "Cloudflare project name"
  type        = string
  default = "production-purple-rain"
}

variable "access_app_name" {
  type        = string
  description = "Name of the access app"
  default     = "production-purple-rain"
}

variable "production_branch" {
  description = "Describe the production branch for this project"
  type        = string
  default     = "master"
}

variable "protected_domain" {
  description = "The domain that has to be protected with Zero Trust"
  type        = string

  validation {
condition     = replace(var.protected_domain, "/^.*\\.qredo\\.com$/", "qredo.com") != "qredo.com"
    error_message = "The domain 'qredo.com' is not allowed. Please provide a different domain or a subdomain of 'qredo.com."
  }
}

variable "allowed_emails" {
  description = "Allow emails ending in"
  type        = string
  default     = "@qredo.com"
}

variable "policy_name" {
  type        = string
  default     = "production-purple-rain"
  description = "Name of the policy associated with the access application."
}

