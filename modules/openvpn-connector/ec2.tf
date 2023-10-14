module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name                   = var.name
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_pair_name
  vpc_security_group_ids = [module.security_group.security_group_id]
  subnet_id              = var.subnet_id
  source_dest_check      = false

  tags = var.tags
}

locals {
  install_openvpn_file_path     = "${path.module}/user-data/install_openvpn_connector.tftpl"
  openvpn_connector_output_path = "./openvpn-connector-output.txt"
}

resource "null_resource" "install_openvpn" {
  depends_on = [module.ec2_instance]

  triggers = {
    install_openvpn_file = filesha256(local.install_openvpn_file_path)
    instance_ami         = var.ami
    instance_type        = var.instance_type
    instance_private_ip  = module.ec2_instance.private_ip
    openvpn_token        = var.openvpn_token
  }

  connection {
    host        = module.ec2_instance.private_ip
    user        = "ubuntu"
    private_key = var.key_pair_value
  }

  provisioner "remote-exec" {
    inline = [
      templatefile(
        local.install_openvpn_file_path,
        {
          openvpn_connector_output_path = local.openvpn_connector_output_path
          openvpn_repo_pkg_key_url      = var.openvpn_repo_pkg_key_url,
          openvpn_repo_url              = var.openvpn_repo_url,
          openvpn_token                 = var.openvpn_token
        }
      )
    ]
  }
}