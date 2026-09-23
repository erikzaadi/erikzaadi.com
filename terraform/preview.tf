# blogpreview.erikzaadi.com - draft-inclusive build from any non-master branch.
# Created here (not imported), fronts the existing private S3 bucket via OAC.

locals {
  preview_domain = "blogpreview.erikzaadi.com"
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

  origin {
    domain_name              = data.aws_s3_bucket.site["preview"].bucket_regional_domain_name
    origin_id                = "s3-${local.preview_domain}"
    origin_access_control_id = aws_cloudfront_origin_access_control.site.id
  }

  default_cache_behavior {
    target_origin_id       = "s3-${local.preview_domain}"
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    cache_policy_id        = data.aws_cloudfront_cache_policy.caching_disabled.id

    function_association {
      event_type   = "viewer-request"
      function_arn = aws_cloudfront_function.index_rewrite.arn
    }
  }

  # Private bucket: a missing object is a 403 (no ListBucket), treat both as not found
  custom_error_response {
    error_code            = 403
    response_code         = 404
    response_page_path    = "/404.html"
    error_caching_min_ttl = 0
  }

  custom_error_response {
    error_code            = 404
    response_code         = 404
    response_page_path    = "/404.html"
    error_caching_min_ttl = 0
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
