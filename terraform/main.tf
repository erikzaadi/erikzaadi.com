terraform {
  required_version = ">= 1.6"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# ACM certificates for CloudFront must be in us-east-1
provider "aws" {
  region = "us-east-1"
}

# Look up the existing Route 53 hosted zone - do not manage it here
data "aws_route53_zone" "main" {
  name         = var.hosted_zone_name
  private_zone = false
}

# Amazon-issued ACM certificates - AWS renews these automatically as long as
# the DNS validation records exist and the cert is attached to CloudFront
resource "aws_acm_certificate" "site" {
  for_each          = var.sites
  domain_name       = each.key
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

# Route 53 DNS validation records for ACM
resource "aws_route53_record" "cert_validation" {
  for_each = {
    for dvo in flatten([
      for cert in aws_acm_certificate.site : tolist(cert.domain_validation_options)
      ]) : dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      record = dvo.resource_record_value
    }
  }

  zone_id = data.aws_route53_zone.main.zone_id
  name    = each.value.name
  type    = each.value.type
  records = [each.value.record]
  ttl     = 60

  allow_overwrite = true
}

resource "aws_acm_certificate_validation" "site" {
  for_each                = var.sites
  certificate_arn         = aws_acm_certificate.site[each.key].arn
  validation_record_fqdns = [aws_route53_record.cert_validation[each.key].fqdn]
}
