module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  count = var.instance_count

  name = "${var.name_prefix}-${count.index + 1}"

  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_pair_name
  vpc_security_group_ids = [module.security_group.security_group_id]
  subnet_id              = element(var.subnet_ids, count.index)

  tags = var.tags
}
