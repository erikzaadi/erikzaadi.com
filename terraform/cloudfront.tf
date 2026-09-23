# erikzaadi.com and slides.erikzaadi.com distributions (imported once, then trimmed to non-default settings).
# blogpreview lives in preview.tf.

# Honors origin Cache-Control (s-maxage set by hugo deploy), gzip/brotli at the edge
data "aws_cloudfront_cache_policy" "caching_optimized" {
  name = "Managed-CachingOptimized"
}

# /path/ -> /path/index.html and /path -> /path/, what the S3 website endpoint used to do
resource "aws_cloudfront_function" "index_rewrite" {
  name    = "erikzaadi-com-index-rewrite"
  runtime = "cloudfront-js-2.0"
  comment = "Directory index + trailing slash redirect for private S3 origins"
  publish = true
  code    = file("${path.module}/functions/index-rewrite.js")
}

# erikzaadi.com
resource "aws_cloudfront_distribution" "main" {
  aliases         = ["erikzaadi.com"]
  enabled         = true
  http_version    = "http2and3"
  is_ipv6_enabled = true
  price_class     = "PriceClass_100"

  origin {
    domain_name              = data.aws_s3_bucket.site["production"].bucket_regional_domain_name
    origin_id                = "s3-erikzaadi.com"
    origin_access_control_id = aws_cloudfront_origin_access_control.site.id
  }

  default_cache_behavior {
    target_origin_id       = "s3-erikzaadi.com"
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    compress               = true
    cache_policy_id        = data.aws_cloudfront_cache_policy.caching_optimized.id

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
    error_caching_min_ttl = 300
  }

  custom_error_response {
    error_code            = 404
    response_code         = 404
    response_page_path    = "/404.html"
    error_caching_min_ttl = 300
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate_validation.site["erikzaadi.com"].certificate_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }
}

# slides.erikzaadi.com
resource "aws_cloudfront_distribution" "slides" {
  aliases         = ["slides.erikzaadi.com"]
  enabled         = true
  http_version    = "http2and3"
  is_ipv6_enabled = true
  price_class     = "PriceClass_100"

  origin {
    domain_name              = data.aws_s3_bucket.site["slides"].bucket_regional_domain_name
    origin_id                = "s3-slides.erikzaadi.com"
    origin_access_control_id = aws_cloudfront_origin_access_control.site.id
  }

  default_cache_behavior {
    target_origin_id       = "s3-slides.erikzaadi.com"
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    compress               = true
    cache_policy_id        = data.aws_cloudfront_cache_policy.caching_optimized.id

    function_association {
      event_type   = "viewer-request"
      function_arn = aws_cloudfront_function.index_rewrite.arn
    }
  }

  # The root index.html is the "looking for a specific slide?" page, served as the 404
  custom_error_response {
    error_code            = 403
    response_code         = 404
    response_page_path    = "/index.html"
    error_caching_min_ttl = 300
  }

  custom_error_response {
    error_code            = 404
    response_code         = 404
    response_page_path    = "/index.html"
    error_caching_min_ttl = 300
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate_validation.site["slides.erikzaadi.com"].certificate_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }
}
