locals {
  create_access_application = var.access_application
  create_access_policy      = var.access_policy
}

resource "cloudflare_pages_project" "basic_project" {
  account_id        = var.account_id
  name              = var.project_name
  production_branch = var.production_branch
}

resource "cloudflare_access_application" "basic_app" {
  count            = local.create_access_application ? 1 : 0
  account_id       = var.account_id
  name             = var.access_app_name
  domain           = var.protected_domain
  type             = "self_hosted"
  session_duration = "24h"
}

resource "cloudflare_access_policy" "basic_policy" {
  count          = local.create_access_policy && local.create_access_application ? 1 : 0
  application_id = cloudflare_access_application.basic_app[0].id
  account_id     = var.account_id
  name           = var.policy_name
  precedence     = "1"
  decision       = "allow"

  include {
    email_domain = [var.allowed_emails]
  }
}
