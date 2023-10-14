resource "aws_route53_zone" "this" {
  count = var.create && var.create_route53_zone ? 1 : 0

  name = var.domain_name
  tags = var.tags
}

data "aws_route53_zone" "this" {
  count = var.create && !var.create_route53_zone ? 1 : 0

  name  = var.domain_name
}

locals {
  aws_route53_zone_id           = var.create ? (var.create_route53_zone ? aws_route53_zone.this[0].zone_id : data.aws_route53_zone.this[0].zone_id) : ""
  aws_route53_zone_name_servers = var.create ? (var.create_route53_zone ? aws_route53_zone.this[0].name_servers : data.aws_route53_zone.this[0].name_servers) : []

  domain_name_prefix = var.create ? (var.domain_name_prefix == "" ? "" : "${var.domain_name_prefix}.") : null
}

resource "aws_route53_record" "cname_record" {
  count = var.create && local.domain_name_prefix != "" ? 1 : 0

  zone_id = local.aws_route53_zone_id
  name    = "${local.domain_name_prefix}${var.domain_name}"
  type    = "CNAME"
  ttl     = 300
  records = [module.cloudfront_s3[0].cloudfront_distribution_domain_name]
}

resource "aws_route53_record" "a_record" {
  count = var.create && local.domain_name_prefix == "" ? 1 : 0

  zone_id = local.aws_route53_zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = module.cloudfront_s3[0].cloudfront_distribution_domain_name
    zone_id                = module.cloudfront_s3[0].cloudfront_distribution_hosted_zone_id
    evaluate_target_health = true
  }
}

resource "cloudflare_record" "redirection" {
  count = var.create && (var.validation_type == "cloudflare") ? 4 : 0

  zone_id         = data.cloudflare_zone.this[0].id
  allow_overwrite = true
  proxied         = false
  name            = trimsuffix(var.domain_name, ".${var.cloudflare_zone}")
  type            = "NS"
  value           = local.aws_route53_zone_name_servers[count.index]
}