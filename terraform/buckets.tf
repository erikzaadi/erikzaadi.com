# Existing site buckets (not created here), served privately through CloudFront via OAC.
# Only their access settings are managed: bucket policy, and once public read is off,
# Block Public Access + ACLs disabled.

variable "allow_public_read" {
  description = "Legacy public read on the buckets. Off since the move to OAC, set to true only as a rollback if CloudFront can't read the buckets"
  type        = bool
  default     = false
}

locals {
  # Buckets the GitHub deploy role writes to (slides is deployed elsewhere)
  deploy_buckets = {
    production = "erikzaadi.com"
    preview    = "blogpreview.erikzaadi.com"
  }

  site_buckets = merge(local.deploy_buckets, {
    slides = "slides.erikzaadi.com"
  })

  site_distribution_arns = {
    production = aws_cloudfront_distribution.main.arn
    preview    = aws_cloudfront_distribution.preview.arn
    slides     = aws_cloudfront_distribution.slides.arn
  }
}

data "aws_s3_bucket" "site" {
  for_each = local.site_buckets
  bucket   = each.value
}

resource "aws_cloudfront_origin_access_control" "site" {
  name                              = "erikzaadi-com-sites"
  description                       = "CloudFront access to the private site buckets"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

data "aws_iam_policy_document" "site" {
  for_each = local.site_buckets

  # Only this bucket's own distribution may read it. No s3:ListBucket, so a missing
  # object is a 403, which the distributions map to their 404 page.
  statement {
    sid       = "CloudFrontRead"
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::${each.value}/*"]

    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [local.site_distribution_arns[each.key]]
    }
  }

  dynamic "statement" {
    for_each = var.allow_public_read ? [1] : []
    content {
      sid       = "PublicRead"
      actions   = ["s3:GetObject"]
      resources = ["arn:aws:s3:::${each.value}/*"]

      principals {
        type        = "*"
        identifiers = ["*"]
      }
    }
  }
}

resource "aws_s3_bucket_policy" "site" {
  for_each = local.site_buckets
  bucket   = each.value
  policy   = data.aws_iam_policy_document.site[each.key].json

  depends_on = [aws_s3_bucket_public_access_block.site]
}

# Phase 2: lock the buckets down once public read is off
resource "aws_s3_bucket_public_access_block" "site" {
  for_each = var.allow_public_read ? {} : local.site_buckets
  bucket   = each.value

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

# Disables ACLs, uploads with --acl public-read fail from here on
resource "aws_s3_bucket_ownership_controls" "site" {
  for_each = var.allow_public_read ? {} : local.site_buckets
  bucket   = each.value

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}
