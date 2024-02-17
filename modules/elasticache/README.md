## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 4.52.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.52.0 |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_data_protection_policy.this](https://registry.terraform.io/providers/hashicorp/aws/4.52.0/docs/resources/cloudwatch_log_data_protection_policy) | resource |
| [aws_cloudwatch_log_group.redis](https://registry.terraform.io/providers/hashicorp/aws/4.52.0/docs/resources/cloudwatch_log_group) | resource |
| [aws_elasticache_replication_group.this](https://registry.terraform.io/providers/hashicorp/aws/4.52.0/docs/resources/elasticache_replication_group) | resource |
| [aws_elasticache_subnet_group.this](https://registry.terraform.io/providers/hashicorp/aws/4.52.0/docs/resources/elasticache_subnet_group) | resource |
| [aws_kms_alias.this](https://registry.terraform.io/providers/hashicorp/aws/4.52.0/docs/resources/kms_alias) | resource |
| [aws_kms_key.redis](https://registry.terraform.io/providers/hashicorp/aws/4.52.0/docs/resources/kms_key) | resource |
| [aws_s3_bucket.redis_logs](https://registry.terraform.io/providers/hashicorp/aws/4.52.0/docs/resources/s3_bucket) | resource |
| [aws_security_group.redis](https://registry.terraform.io/providers/hashicorp/aws/4.52.0/docs/resources/security_group) | resource |
| [random_id.s3](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_at_rest_encryption_enabled"></a> [at\_rest\_encryption\_enabled](#input\_at\_rest\_encryption\_enabled) | Enable at rest encryption. True by default. | `bool` | `true` | no |
| <a name="input_description"></a> [description](#input\_description) | Optional. Redis description. | `string` | `"Redis Cluster Production"` | no |
| <a name="input_egress_cidr"></a> [egress\_cidr](#input\_egress\_cidr) | Optional. Specify egress rule for Redis security group. | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_enable_key_rotation"></a> [enable\_key\_rotation](#input\_enable\_key\_rotation) | Specifies whether key rotation is enabled. Defaults to false. | `bool` | `false` | no |
| <a name="input_failover"></a> [failover](#input\_failover) | Optional. Enable failover. True by default | `bool` | `"true"` | no |
| <a name="input_group_id"></a> [group\_id](#input\_group\_id) | Redis group ID. Moreover, used for naming of some resources like logs and buckets | `string` | n/a | yes |
| <a name="input_ingress_cidr"></a> [ingress\_cidr](#input\_ingress\_cidr) | Required. Specify ingress rule for Redis security group. | `list(string)` | n/a | yes |
| <a name="input_kms_alias"></a> [kms\_alias](#input\_kms\_alias) | KMS Alias | `string` | `"alias/redis"` | no |
| <a name="input_log_retention"></a> [log\_retention](#input\_log\_retention) | Optional. Log data retention. 180 days (6 months) by default | `number` | `180` | no |
| <a name="input_multi_az_enabled"></a> [multi\_az\_enabled](#input\_multi\_az\_enabled) | Optional. Multi AZ enabled by default. | `bool` | `true` | no |
| <a name="input_node_type"></a> [node\_type](#input\_node\_type) | Required. Node type for Redis. Supported types - https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/CacheNodes.SupportedTypes.html | `string` | n/a | yes |
| <a name="input_num_cache_clusters"></a> [num\_cache\_clusters](#input\_num\_cache\_clusters) | Optional. Number of cache cluster. | `number` | `3` | no |
| <a name="input_num_node_groups"></a> [num\_node\_groups](#input\_num\_node\_groups) | Optional.The number of node groups. | `number` | `1` | no |
| <a name="input_parameter_group_name"></a> [parameter\_group\_name](#input\_parameter\_group\_name) | Optional. Group name. By default - default.redis7. | `string` | `"default.redis7"` | no |
| <a name="input_port"></a> [port](#input\_port) | Optional. Redis port. | `number` | `6379` | no |
| <a name="input_replicas_per_node_group"></a> [replicas\_per\_node\_group](#input\_replicas\_per\_node\_group) | Required. Select the number of replica for the node group. | `number` | n/a | yes |
| <a name="input_snapshot_retention"></a> [snapshot\_retention](#input\_snapshot\_retention) | Optional. The number of days AWS will store a snapshot before it's retained. | `number` | `3` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | Required. Define subnets ids of the VPC. | `list(string)` | n/a | yes |
| <a name="input_tansit_encryption"></a> [tansit\_encryption](#input\_tansit\_encryption) | Optional. Data in transit encryption. Enabled by default | `bool` | `true` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | Required. Define the VPC in which redis will be deployed. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_availability_zones"></a> [availability\_zones](#output\_availability\_zones) | Availability zones |
| <a name="output_kms_id"></a> [kms\_id](#output\_kms\_id) | Return kms key id |
| <a name="output_reader_endpoint_address"></a> [reader\_endpoint\_address](#output\_reader\_endpoint\_address) | Reader endpoint address |
| <a name="output_redis_endpoint"></a> [redis\_endpoint](#output\_redis\_endpoint) | Return Redis primary endpoint. |
| <a name="output_rest_encryption"></a> [rest\_encryption](#output\_rest\_encryption) | At rest encryption status |
| <a name="output_s3_name"></a> [s3\_name](#output\_s3\_name) | Return s3 id |
| <a name="output_transit_encryption"></a> [transit\_encryption](#output\_transit\_encryption) | Transit encryption status |