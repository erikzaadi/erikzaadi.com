output "certificate_arns" {
  value = { for domain, v in aws_acm_certificate_validation.site : domain => v.certificate_arn }
}

output "github_actions_role_arn" {
  description = "Set as the AWS_ROLE_ARN secret in the GitHub repo"
  value       = aws_iam_role.github_deploy.arn
}

output "cloudfront_distribution_ids" {
  value = {
    main    = aws_cloudfront_distribution.main.id
    slides  = aws_cloudfront_distribution.slides.id
    preview = aws_cloudfront_distribution.preview.id
  }
}
