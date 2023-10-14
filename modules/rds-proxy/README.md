## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.8.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.8.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_db_proxy.rds-proxy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_proxy) | resource |
| [aws_db_proxy_default_target_group.target-group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_proxy_default_target_group) | resource |
| [aws_db_proxy_target.target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_proxy_target) | resource |
| [aws_iam_policy.rds-proxy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.rds-proxy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_secretsmanager_secret.rds-proxy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_security_group.allow_rds](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.ingress_rds](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_iam_policy_document.rds-proxy-assume-role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_key"></a> [access\_key](#input\_access\_key) | n/a | `string` | `"Not Set"` | no |
| <a name="input_allowed_ingress_cidr_blocks"></a> [allowed\_ingress\_cidr\_blocks](#input\_allowed\_ingress\_cidr\_blocks) | n/a | `list(string)` | n/a | yes |
| <a name="input_db_cluster_identifier"></a> [db\_cluster\_identifier](#input\_db\_cluster\_identifier) | RDS Cluster name | `string` | n/a | yes |
| <a name="input_iam_settings"></a> [iam\_settings](#input\_iam\_settings) | n/a | <pre>object({<br>    policy_name        = string<br>    policy_description = string<br>    role_name          = string<br>  })</pre> | n/a | yes |
| <a name="input_proxy_auth_settings"></a> [proxy\_auth\_settings](#input\_proxy\_auth\_settings) | n/a | <pre>object({<br>    auth_scheme               = string<br>    description               = string<br>    iam_auth                  = string<br>    client_password_auth_type = string<br>  })</pre> | n/a | yes |
| <a name="input_proxy_settings"></a> [proxy\_settings](#input\_proxy\_settings) | n/a | <pre>object({<br>    name                = string<br>    debug_logging       = bool<br>    engine_family       = string<br>    idle_client_timeout = number<br>    require_tls         = bool<br>    vpc_subnet_ids      = list(string)<br>  })</pre> | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS Region | `string` | `"eu-west-1"` | no |
| <a name="input_secret_key"></a> [secret\_key](#input\_secret\_key) | n/a | `string` | `"Not Set"` | no |
| <a name="input_secret_values"></a> [secret\_values](#input\_secret\_values) | n/a | `map(string)` | <pre>{<br>  "password": "mystrongpassword",<br>  "username": "postgres"<br>}</pre> | no |
| <a name="input_secrets_settings"></a> [secrets\_settings](#input\_secrets\_settings) | n/a | <pre>object({<br>    name                    = string<br>    description             = string<br>    recovery_window_in_days = number<br>  })</pre> | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ingress_rules"></a> [ingress\_rules](#output\_ingress\_rules) | n/a |
| <a name="output_proxy-role"></a> [proxy-role](#output\_proxy-role) | n/a |
| <a name="output_proxy-settings"></a> [proxy-settings](#output\_proxy-settings) | n/a |
| <a name="output_proxy-target-group"></a> [proxy-target-group](#output\_proxy-target-group) | n/a |
| <a name="output_rds-proxy-endpoint"></a> [rds-proxy-endpoint](#output\_rds-proxy-endpoint) | n/a |
| <a name="output_secret-arn"></a> [secret-arn](#output\_secret-arn) | n/a |
| <a name="output_secret-recovery-window"></a> [secret-recovery-window](#output\_secret-recovery-window) | n/a |