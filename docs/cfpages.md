## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |
| <a name="requirement_cloudflare"></a> [cloudflare](#requirement\_cloudflare) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_cloudflare"></a> [cloudflare](#provider\_cloudflare) | ~> 3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [cloudflare_access_application.basic_app](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/access_application) | resource |
| [cloudflare_access_policy.basic_policy](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/access_policy) | resource |
| [cloudflare_pages_project.basic_project](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/pages_project) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_app_name"></a> [access\_app\_name](#input\_access\_app\_name) | Access Application name | `string` | n/a | yes |
| <a name="input_access_domain"></a> [access\_domain](#input\_access\_domain) | The domain that has to be protected with Zero Trust | `string` | n/a | yes |
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | Cloudflare account ID | `string` | n/a | yes |
| <a name="input_email_protection"></a> [email\_protection](#input\_email\_protection) | Allow emails ending in | `string` | n/a | yes |
| <a name="input_policy_name"></a> [policy\_name](#input\_policy\_name) | Zero Trust Policy Name | `string` | n/a | yes |
| <a name="input_production_branch"></a> [production\_branch](#input\_production\_branch) | Describe the production branch for this project | `string` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Cloudflare project name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_access_app_id"></a> [access\_app\_id](#output\_access\_app\_id) | n/a |
| <a name="output_policy_app_id"></a> [policy\_app\_id](#output\_policy\_app\_id) | n/a |
| <a name="output_project_name_id"></a> [project\_name\_id](#output\_project\_name\_id) | n/a |