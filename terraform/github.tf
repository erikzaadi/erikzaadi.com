# GitHub Actions OIDC - short-lived credentials for the deploy workflow, no static AWS keys.
# Set the github_actions_role_arn output as the AWS_ROLE_ARN secret in the repo.

variable "github_repository" {
  description = "owner/repo allowed to assume the deploy role"
  type        = string
  default     = "erikzaadi/erikzaadi.com"
}

resource "aws_iam_openid_connect_provider" "github" {
  url            = "https://token.actions.githubusercontent.com"
  client_id_list = ["sts.amazonaws.com"]
}

data "aws_iam_policy_document" "github_assume" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.github.arn]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    # Any branch: master deploys production, everything else the preview
    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["repo:${var.github_repository}:ref:refs/heads/*"]
    }
  }
}

resource "aws_iam_role" "github_deploy" {
  name               = "erikzaadi-com-github-deploy"
  assume_role_policy = data.aws_iam_policy_document.github_assume.json
}

data "aws_iam_policy_document" "github_deploy" {
  # hugo deploy: list, compare, upload, delete
  statement {
    actions   = ["s3:ListBucket"]
    resources = [for b in values(local.deploy_buckets) : "arn:aws:s3:::${b}"]
  }

  statement {
    actions   = ["s3:GetObject", "s3:PutObject", "s3:DeleteObject"]
    resources = [for b in values(local.deploy_buckets) : "arn:aws:s3:::${b}/*"]
  }

  # Production deploy invalidates the main distribution
  statement {
    actions   = ["cloudfront:CreateInvalidation", "cloudfront:GetInvalidation"]
    resources = [aws_cloudfront_distribution.main.arn]
  }
}

resource "aws_iam_role_policy" "github_deploy" {
  name   = "deploy"
  role   = aws_iam_role.github_deploy.id
  policy = data.aws_iam_policy_document.github_deploy.json
}
