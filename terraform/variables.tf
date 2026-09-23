variable "hosted_zone_name" {
  description = "Existing Route 53 hosted zone"
  type        = string
  default     = "erikzaadi.com"
}

variable "sites" {
  description = "Domains served via CloudFront that get an auto-renewing ACM certificate"
  type        = set(string)
  default     = ["erikzaadi.com", "slides.erikzaadi.com", "blogpreview.erikzaadi.com"]
}
