data "aws_s3_bucket" "this" {
  count = var.create ? 1 : 0

  bucket = var.s3_bucket
}

resource "aws_cloudfront_function" "basic_auth" {
  count = var.create ? 1 : 0

  name    = "BasicAuth_${replace(var.domain_name, ".", "_")}"
  runtime = "cloudfront-js-1.0"
  code    = templatefile(
    "${path.module}/basic-auth.js.tftpl",
    {
      user_password_base64 = var.user_password_base64
    }
  )
}

module "cloudfront_s3" {
  source = "terraform-aws-modules/cloudfront/aws"

  count = var.create ? 1 : 0

  aliases = ["${local.domain_name_prefix}${var.domain_name}"]

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = var.cloudfront_default_root_object
  price_class         = var.cloudfront_price_class
  retain_on_delete    = false
  wait_for_deployment = false

  create_origin_access_identity = true
  origin_access_identities = {
    s3_bucket = "Cloudfront access to ${var.s3_bucket} S3 bucket"
  }

  origin = {
    s3_bucket = {
      domain_name = data.aws_s3_bucket.this[0].bucket_regional_domain_name
      s3_origin_config = {
        origin_access_identity = "s3_bucket"
      }
    }
  }

  default_cache_behavior = {
    target_origin_id           = "s3_bucket"
    viewer_protocol_policy     = "allow-all"
    allowed_methods            = ["GET", "HEAD"]
    cached_methods             = ["GET", "HEAD"]
    compress                   = true
    min_ttl                    = 0
    default_ttl                = 3600
    max_ttl                    = 7200

    function_association = {
      viewer-request = {
        function_arn = aws_cloudfront_function.basic_auth[0].arn
      }
    }
  }

  viewer_certificate = {
    acm_certificate_arn = module.acm[0].acm_certificate_arn
    ssl_support_method  = "sni-only"
  }

  tags = var.tags
}

data "aws_s3_bucket_policy" "this" {
  count = var.create ? 1 : 0

  bucket = var.s3_bucket
}

data "aws_iam_policy_document" "this" {
  count = var.create ? 1 : 0

  source_policy_documents = [
    data.aws_s3_bucket_policy.this[0].policy
  ]

  statement {
    sid       = "AllowCloudfrontGetObject"
    actions   = ["s3:GetObject"]
    resources = ["${data.aws_s3_bucket.this[0].arn}/*"]

    principals {
      type        =  "AWS"
      identifiers = module.cloudfront_s3[0].cloudfront_origin_access_identity_iam_arns
    }
  }

  statement {
    sid       = "AllowCloudfrontListBucket"
    actions   = ["s3:ListBucket"]
    resources = [data.aws_s3_bucket.this[0].arn]

    principals {
      type        = "AWS"
      identifiers = module.cloudfront_s3[0].cloudfront_origin_access_identity_iam_arns
    }
  }
}

resource "aws_s3_bucket_policy" "this" {
  count = var.create ? 1 : 0
  
  bucket = data.aws_s3_bucket.this[0].id
  policy = data.aws_iam_policy_document.this[0].json
}