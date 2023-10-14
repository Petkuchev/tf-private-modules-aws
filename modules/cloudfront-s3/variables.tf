### Providers variables ###
variable "cloudflare_global_api_token" {
  type        = string
  description = "Cloudflare Api Token used on the Cloudflare provider"
  sensitive   = true
}

### Module variables ###
variable "cloudflare_zone" {
  type        = string
  description = "Cloudflare Zone name"
}

variable "cloudfront_default_root_object" {
  type        = string
  description = "Default object name returned from Cloudfront when accessing to the S3 bucket"
  default = null
}

variable "cloudfront_price_class" {
  type        = string
  description = "Cloudfront price class"
}

variable "create" {
  type        = bool
  description = "Wheter to create or not all the resources in the module"
  default     = true
}

variable "create_route53_zone" {
  type        = bool
  description = "Wheter to create or not the Route53 zone"
  default     = true
}

variable "domain_name" {
  type        = string
  description = "Domain name used for creating or fetching and using Route53 zone, ACM domain name and alternative names, etc"
}

variable "domain_name_prefix" {
  type        = string
  description = "Prefix used to create a CNAME from the domain_name"
}

variable "s3_bucket" {
  type        = string
  description = "S3 Bucket name that Cloudfront will use as source"
}

variable "tags" {
  type        = map(string)
  description = "Map of tags used on all the resources"
  default     = {}
}

variable "user_password_base64" {
  type        = string
  description = "Base64 encoded user and password for Cloudfront basic auth. The format should be username:password"
  sensitive   = true
}

variable "validation_type" {
  type        = string
  description = "Type of validation used for the ACM domain. Valid values are route53 or cloudflare"

  validation {
    condition     = var.validation_type == "route53" || var.validation_type == "cloudflare"
    error_message = "Valid values are route53 or cloudflare"
  }
}