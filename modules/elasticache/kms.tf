resource "aws_kms_key" "redis" {
  key_usage                = "ENCRYPT_DECRYPT"
  is_enabled               = true
  enable_key_rotation      = var.enable_key_rotation
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  multi_region             = false
}

resource "aws_kms_alias" "this" {
  name          = var.kms_alias
  target_key_id = aws_kms_key.redis.key_id
}

