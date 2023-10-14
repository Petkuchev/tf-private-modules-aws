data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

resource "aws_elasticsearch_domain" "opensearch" {
  domain_name           = var.domain
  elasticsearch_version = var.es_version

  cluster_config {
    dedicated_master_enabled = false
    instance_type            = var.instance_type
    instance_count           = var.instance_count
    zone_awareness_enabled   = true
    zone_awareness_config {
      availability_zone_count = "3"
    }
  }

  ebs_options {
    ebs_enabled = true
    volume_size = var.volume_size
    volume_type = var.volume_type
  }


  advanced_security_options {
    enabled                        = true
    internal_user_database_enabled = true

    master_user_options {
      master_user_name     = var.master_user_name
      master_user_password = var.master_user_password
    }
  }

  node_to_node_encryption {
    enabled = true
  }

  encrypt_at_rest {
    enabled = true
  }

  domain_endpoint_options {
    enforce_https       = true
    tls_security_policy = "Policy-Min-TLS-1-2-2019-07"

    custom_endpoint_enabled = false
  }

  access_policies = <<CONFIG
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "es:*",
            "Principal": "*",
            "Effect": "Allow",
            "Resource": "arn:aws:es:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:domain/${var.domain}/*"
        }
    ]
}
CONFIG

  vpc_options {
    subnet_ids         = var.subnet_ids
    security_group_ids = [aws_security_group.opensearch_sg.id]
  }

  depends_on = [
    aws_security_group.opensearch_sg
  ]
}
