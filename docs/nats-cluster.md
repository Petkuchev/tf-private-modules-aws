## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.0 |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ec2_instance"></a> [ec2\_instance](#module\_ec2\_instance) | terraform-aws-modules/ec2-instance/aws | ~> 3.0 |
| <a name="module_security_group"></a> [security\_group](#module\_security\_group) | terraform-aws-modules/security-group/aws | ~> 4.16 |

## Resources

| Name | Type |
|------|------|
| [aws_lb.nlb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_listener.nlb_listener](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_target_group.nlb_tg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_lb_target_group_attachment.nlb_tg_attachments](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment) | resource |
| [null_resource.install_nats](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [aws_subnet.subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami"></a> [ami](#input\_ami) | AWS AMI used for the NATS cluster instances | `string` | n/a | yes |
| <a name="input_client_cidr_block"></a> [client\_cidr\_block](#input\_client\_cidr\_block) | CIDR block that will access to the NATS cluster as a client | `string` | n/a | yes |
| <a name="input_cluster_size"></a> [cluster\_size](#input\_cluster\_size) | The desired size for the NATS cluster | `number` | `3` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment where resources are deployed | `string` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | AWS Instance type used for the NATS cluster instances | `string` | `"t2.micro"` | no |
| <a name="input_key_pair_name"></a> [key\_pair\_name](#input\_key\_pair\_name) | AWS Key pair name used for the NATS cluster instances | `string` | n/a | yes |
| <a name="input_key_pair_value"></a> [key\_pair\_value](#input\_key\_pair\_value) | AWS Key pair value used for the NATS cluster instances | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Prefix for the NATS cluster resources. Ex: nats-cluster-1, nats-cluster-nlb, etc. Where the prefix is 'nats-cluster' | `string` | `"nats-cluster"` | no |
| <a name="input_nats_cert"></a> [nats\_cert](#input\_nats\_cert) | NATS cluster private certificate value | `string` | n/a | yes |
| <a name="input_nats_key"></a> [nats\_key](#input\_nats\_key) | NATS cluster private key value | `string` | n/a | yes |
| <a name="input_root_ca"></a> [root\_ca](#input\_root\_ca) | NATS cluster rootCA certificate value | `string` | n/a | yes |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | List of AWS Subnet ids where the NATS cluster servers will be located | `list(string)` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | AWS VPC id where the NATS cluster servers will be located | `string` | n/a | yes |
| <a name="input_vpn_cidr_block"></a> [vpn\_cidr\_block](#input\_vpn\_cidr\_block) | VPN CIDR block | `string` | `"100.96.0.0/16"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_ports"></a> [cluster\_ports](#output\_cluster\_ports) | n/a |
| <a name="output_load_balancer_dns_name"></a> [load\_balancer\_dns\_name](#output\_load\_balancer\_dns\_name) | n/a |