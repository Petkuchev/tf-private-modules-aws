data "aws_ami" "cis" {
  owners      = var.owners
  most_recent = true
  filter {
    name   = "name"
    values = var.filter_name_value
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "random_pet" "bastion" {
  keepers = {
    prefix = var.sg_name_prefix
  }
}

resource "time_static" "Creation_time" {

}

resource "aws_instance" "bastion" {
  ami             = data.aws_ami.cis.image_id
  instance_type   = var.instance_type
  subnet_id       = var.subnet_id
  security_groups = [aws_security_group.bastion.id]
  tags            = var.tags
}

resource "aws_security_group" "bastion" {
  name        = "Bastion-${random_pet.bastion.id}"
  description = "Allow outside ssh access."
  vpc_id      = var.vpc_id
  tags        = var.tags
}

resource "aws_security_group_rule" "bastion_ingress" {
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = var.ingress_cidr
  security_group_id = aws_security_group.bastion.id
}

resource "aws_security_group_rule" "allow_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.bastion.id
  cidr_blocks       = var.egress_cidr
}