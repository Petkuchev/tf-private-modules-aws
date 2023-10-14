module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "~> 4.0"

  count = var.create ? 1 : 0

  providers = {
    aws = aws.us-east-1
  }

  domain_name  = var.domain_name
  zone_id      = local.aws_route53_zone_id

  subject_alternative_names = [
    "*.${var.domain_name}"
  ]

  create_route53_records  = var.validation_type == "cloudflare" ? false : true
  validation_record_fqdns = var.validation_type == "cloudflare" ? cloudflare_record.validation[*].hostname : []
  validation_timeout      = "10m"

  tags = var.tags
}

data "cloudflare_zone" "this" {
  count = var.create && (var.validation_type == "cloudflare") ? 1 : 0

  name = var.cloudflare_zone
}

resource "cloudflare_record" "validation" {
  count = var.create && (var.validation_type == "cloudflare") ? length(module.acm[0].distinct_domain_names) : 0

  zone_id = data.cloudflare_zone.this[0].id
  name    = element(module.acm[0].validation_domains, count.index)["resource_record_name"]
  type    = element(module.acm[0].validation_domains, count.index)["resource_record_type"]
  value   = trimsuffix(element(module.acm[0].validation_domains, count.index)["resource_record_value"], ".")
  ttl     = 60
  proxied = false

  allow_overwrite = true
}