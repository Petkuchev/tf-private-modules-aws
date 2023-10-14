resource "aws_db_instance" "rds" {
  db_name                = var.db_name
  identifier             = "${var.db_name}-${var.environment}"
  instance_class         = var.db_instance
  allocated_storage      = var.volume_size
  engine                 = var.db_type
  engine_version         = var.db_type_version
  username               = var.db_username
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.rds.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  parameter_group_name   = aws_db_parameter_group.rds.name
  skip_final_snapshot    = true
  multi_az               = var.enable_multi_az
  ca_cert_identifier     = var.ca_cert_identifier
  storage_encrypted      = var.storage_encrypted
  apply_immediately      = var.db_apply_immediately
  tags = {
    name        = var.db_name
    terraform   = "true"
    environment = var.environment
    repo        = var.tf_git_repo
  }
}

resource "aws_db_parameter_group" "rds" {
  name   = "${var.db_name}${var.environment}"
  family = "${var.db_type}${var.db_type_version}"

  dynamic "parameter" {
    for_each = var.parameter_group
    iterator = item
    content {
      name         = item.value.name
      value        = item.value.value
      apply_method = item.value.apply_method
    }
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    name        = var.db_name
    terraform   = "true"
    environment = var.environment
    repo        = var.tf_git_repo
  }
}

resource "aws_db_subnet_group" "rds" {
  name       = "${var.db_name}${var.environment}"
  subnet_ids = var.subnet_ids

  lifecycle {
    create_before_destroy = true
  }
  tags = {
    name        = var.db_name
    terraform   = "true"
    environment = var.environment
    repo        = var.tf_git_repo
  }
}