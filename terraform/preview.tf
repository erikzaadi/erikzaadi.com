# blogpreview.erikzaadi.com - draft-inclusive build from the preview branch.
# Created here (not imported), fronts the existing public S3 website bucket.

locals {
  preview_domain        = "blogpreview.erikzaadi.com"
  preview_origin_domain = "blogpreview.erikzaadi.com.s3-website-us-east-1.amazonaws.com"
}

# No caching, so preview deploys show up immediately without an invalidation
data "aws_cloudfront_cache_policy" "caching_disabled" {
  name = "Managed-CachingDisabled"
}

resource "aws_cloudfront_distribution" "preview" {
  aliases         = [local.preview_domain]
  enabled         = true
  http_version    = "http2and3"
  is_ipv6_enabled = true
  price_class     = "PriceClass_100"

  # S3 website endpoint (not the REST endpoint) so /path/ resolves to /path/index.html
  origin {
    domain_name = local.preview_origin_domain
    origin_id   = "S3-Website-${local.preview_origin_domain}"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  default_cache_behavior {
    target_origin_id       = "S3-Website-${local.preview_origin_domain}"
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    cache_policy_id        = data.aws_cloudfront_cache_policy.caching_disabled.id
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate_validation.site[local.preview_domain].certificate_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }
}

# Replaces the existing alias to the S3 website endpoint
resource "aws_route53_record" "preview" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = local.preview_domain
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.preview.domain_name
    zone_id                = aws_cloudfront_distribution.preview.hosted_zone_id
    evaluate_target_health = false
  }

  allow_overwrite = true
}

resource "aws_route53_record" "preview_ipv6" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = local.preview_domain
  type    = "AAAA"

  alias {
    name                   = aws_cloudfront_distribution.preview.domain_name
    zone_id                = aws_cloudfront_distribution.preview.hosted_zone_id
    evaluate_target_health = false
  }

  allow_overwrite = true
}
