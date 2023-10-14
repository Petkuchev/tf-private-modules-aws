################################################################################
# KMS KEY
################################################################################
resource "aws_kms_key" "kms-key" {
  description               = var.description
  deletion_window_in_days   = var.kms_deletion_window_in_days
  customer_master_key_spec  = var.kms_customer_master_key_spec
  enable_key_rotation       = var.kms_enable_key_rotation
  is_enabled                = var.kms_key_enabled
  key_usage                 = var.kms_key_usage
  multi_region              = var.kms_multi_region
  tags = merge(var.common_tags, {
    Environment = var.environment
    Application  = var.service_name
  })
}

resource "aws_kms_alias" "kms-key-alias" {
  name          = "alias/${var.kms_name}-${var.environment}"
  target_key_id = aws_kms_key.kms-key.id
}