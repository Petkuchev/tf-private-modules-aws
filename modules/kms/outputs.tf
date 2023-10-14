################################################################################
# OUTPUT
################################################################################

output "kms" {
  description = "The KMS arn"
  value = {
    kms_key_arn   = try(aws_kms_key.kms-key.arn, "")
    kms_key_id    = try(aws_kms_key.kms-key.id, "")
  }
}