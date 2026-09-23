# Existing S3 website buckets, only their policies are managed here.
# hugo deploy doesn't set object ACLs, so public read comes from the bucket policy.

locals {
  site_buckets = {
    production = "erikzaadi.com"
    preview    = "blogpreview.erikzaadi.com"
  }
}

data "aws_iam_policy_document" "site_public_read" {
  for_each = local.site_buckets

  statement {
    sid       = "PublicRead"
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::${each.value}/*"]

    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }
}

# Overwrites the existing policy (production already has the same public read)
resource "aws_s3_bucket_policy" "site" {
  for_each = local.site_buckets
  bucket   = each.value
  policy   = data.aws_iam_policy_document.site_public_read[each.key].json
}
