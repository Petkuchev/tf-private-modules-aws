## Documentation <a name = "cf-pages"></a>

If you are not familiar with Cloudflare provider, please check the documentation:<br>
Terraform Provider docs - [TF Documentation](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs)<br>
Cloudflare terraform docs - [Cloudflate Terraform](https://developers.cloudflare.com/terraform/)

## Cloudflare pages prerequisites 
First thing that has to be considered is how to protect your CF API token. The best way is to export is as an environment variable, like so:
```
export CLOUDFLARE_API_TOKEN=d09***************
```

This way you will protect yourself from accidental commit. 

The second thing are the token permissions. Make sure that their are enough to create CF Pages, Access applications and Access policies. 
Otherwise you will get *Authentication error 10000*. 

## Required variables
Here is an example of how to use the module: <br>
```
module "cf_project" {
  source            = "./modules/cf_pages"
  project_name      = "security-v2"
  production_branch = "main"
  access_app_name   = "security-v2"
  access_domain     = "*.security-v2.pages.dev"
  policy_name       = "pages.dev-protection"
  email_protection  = "@qredo.com"
  account_id        = "d993714d2eb6a13c474f3222f6c934d3"
}
```
**source** - specify the module path. <br>
**project_name** - this is the project name in CF Pages. <br>
**production_branch** - In CF you can have a production branch and preview branch. In our case the deployment is by uploading the files, so this is not linked to the Repository branches. You can select a random name. <br>
**access_app_name** - This is the name for the Access app in order to distinguish  it among the rest. <br>
**access_domain** - the domain that has to be protected.<br>
**policy_name** - The name of the access app policy. <br>
**email_protection** - by default *@qredo.com*. <br> 
**account_id** - Cloudflare account id. <br>

## Resources 

1. Cloudflare pages project
2. Access application in Zero trust
3. Access app policy

## Outputs
**project_name_id** - ```value = cloudflare_pages_project.basic_project.id```<br>
**access_app_id** - ```value = cloudflare_access_application.basic_app.id```<br>
**policy_app_id** - ```value = cloudflare_access_policy.basic_policy.id```<br>

