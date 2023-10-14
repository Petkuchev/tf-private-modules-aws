################################################################################
# VARIABLES
################################################################################

variable "environment" {
  description = "Envitonment"
}

variable "kms_name" {
  description = "Kms key name"
}
variable "description" {
  description = "Description Kms"
}

variable "kms_customer_master_key_spec" {
  description = "KMS customer master key spec"
}

variable "kms_deletion_window_in_days" {
  description = "KMS deletion window in days"
}

variable "kms_enable_key_rotation" {
  description = "KMS enable key rotation"
}

variable "kms_key_enabled" {
  description = "KMS key enable"
}

variable "kms_key_usage" {
  description = "KMS key use for"
}

variable "kms_multi_region" {
  description = "KMS multi region"
}

variable "service_name" {
  description = "Service name in k8s"
}

variable "k8s_service_account_namespace" {
  description = "k8s service account namespace"
}

variable "oidc_provider_id" {
  description = "AWS oidc provider id"
}

variable "cluster_name" {
  description = "EKS cluster_name"
}

variable "account_id" {
  description = "AWS account id"
}

variable "common_tags" {}

variable "region" {
  type    = string
}

variable "iam-role-for-service-accounts-eks" {
  description = "This flag creating role and providing access for k8s SA"
  type    = bool
}

variable "kms_policy_actions" {
  description = "KMS policy actions"
  default = [
    "kms:Decrypt",
    "kms:Encrypt",
    "kms:GenerateDataKey",
    "kms:GenerateDataKeyPair",
    "kms:GenerateDataKeyPairWithoutPlaintext",
    "kms:GenerateDataKeyWithoutPlaintext",
    "kms:ReEncryptFrom",
    "kms:ReEncryptTo"
  ]
}
