## Cloudflare token
You need to create API token with the following access:<br>
Account -> Cloudflare Pages -> Edit<br>
Account -> Zero Trust -> Edit<br>
Account -> Access: Apps and Policies -> Edit<br>

Export the token as an environment  variable: <br>
`export CLOUDFLARE_API_TOKEN=<randomstring>`

Example:

```
module "test" {
  source             = "./cfpages"
  account_id         = "<accountID>"
  name               = "frontend"
  access_domain      = "development-qredo.com"
  access_policy      = true
  access_application = true
}

output "access_id" {
  value = module.test.access_app_id
}
```
If you don't want to create access application and policy, you can omit the arguments.
Note that if access_application is true, you need to have a policy too.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_cloudflare"></a> [cloudflare](#requirement\_cloudflare) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_cloudflare"></a> [cloudflare](#provider\_cloudflare) | ~> 4.0 |

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
| <a name="input_access_application"></a> [access\_application](#input\_access\_application) | Wether to create a access app | `bool` | `false` | no |
| <a name="input_access_domain"></a> [access\_domain](#input\_access\_domain) | The domain that has to be protected with Zero Trust | `string` | n/a | yes |
| <a name="input_access_policy"></a> [access\_policy](#input\_access\_policy) | Wether to create a access policy | `bool` | `false` | no |
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | Cloudflare account ID | `string` | n/a | yes |
| <a name="input_email_protection"></a> [email\_protection](#input\_email\_protection) | Allow emails ending in | `string` | `"@qredo.com"` | no |
| <a name="input_name"></a> [name](#input\_name) | Cloudflare project name | `string` | n/a | yes |
| <a name="input_production_branch"></a> [production\_branch](#input\_production\_branch) | Describe the production branch for this project | `string` | `"master"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_access_app_id"></a> [access\_app\_id](#output\_access\_app\_id) | n/a |
| <a name="output_policy_app_id"></a> [policy\_app\_id](#output\_policy\_app\_id) | n/a |
| <a name="output_project_name_id"></a> [project\_name\_id](#output\_project\_name\_id) | n/a |