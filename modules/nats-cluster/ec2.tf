module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  count = var.cluster_size

  name = "${var.name_prefix}-${count.index + 1}"

  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_pair_name
  vpc_security_group_ids = [module.security_group.security_group_id]
  subnet_id              = element(var.subnet_ids, count.index)

  tags = var.tags
}

locals {
  depends_on = [module.ec2_instance]

  private_ips = module.ec2_instance[*].private_ip

  nats_config_file_path  = "${path.module}/user-data/tmp_nats_jet.tftpl"
  nats_service_file_path = "${path.module}/user-data/nats.service"
  install_nats_file_path = "${path.module}/user-data/install_nats.tftpl"

  nats_remote_folder = "/opt/nats"
  remote_base_path   = "/home/ubuntu"

  server_encrypted_key = "server-encrypted-key.pem"
  server_key           = "server-key.pem"
}

resource "null_resource" "install_nats" {
  depends_on = [module.ec2_instance]

  triggers = {
    cluster_instance_ips = join(",", local.private_ips)
    nats_config_file     = filesha256(local.nats_config_file_path)
    nats_service_file    = filesha256(local.nats_service_file_path)
    install_nats_file    = filesha256(local.install_nats_file_path)
    instance_ami         = var.ami
    instance_type        = var.instance_type
    nats_cert            = var.nats_cert
    nats_key             = var.nats_key
    root_ca              = var.root_ca
  }

  count = var.cluster_size

  connection {
    host        = local.private_ips[count.index]
    user        = "ubuntu"
    private_key = var.key_pair_value
  }

  provisioner "file" {
    content = templatefile(
      local.nats_config_file_path,
      {
        index             = count.index,
        private_ip        = local.private_ips[count.index],
        nats_folder       = local.nats_remote_folder,
        other_private_ips = setsubtract(toset(local.private_ips), [local.private_ips[count.index]])
      }
    )
    destination = "${local.remote_base_path}/nats_jet.conf"
  }

  provisioner "file" {
    source      = local.nats_service_file_path
    destination = "${local.remote_base_path}/nats.service"
  }

  provisioner "file" {
    content = var.nats_cert
    destination = "${local.remote_base_path}/server-cert.pem"
  }

  provisioner "file" {
    content = var.nats_key
    destination = "${local.remote_base_path}/${local.server_encrypted_key}"
  }

  provisioner "file" {
    content = var.root_ca
    destination = "${local.remote_base_path}/rootCA.pem"
  }

  provisioner "remote-exec" {
    inline = [
      templatefile(
        local.install_nats_file_path,
        {
          nats_key_passphrase  = var.nats_key_passphrase
          nats_folder          = local.nats_remote_folder
          server_encrypted_key = local.server_encrypted_key
          server_key           = local.server_key
        }
      )
    ]
  }
}