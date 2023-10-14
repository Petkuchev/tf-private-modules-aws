output "project_name_id" {
  value = cloudflare_pages_project.basic_project.id
}

output "access_app_id" {
  value = cloudflare_access_application.basic_app[*].id
}

output "policy_app_id" {
  value = cloudflare_access_policy.basic_policy[*].id
}