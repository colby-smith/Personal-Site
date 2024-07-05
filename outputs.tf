output "website_url" {
  description = "Website URL (HTTPS)"
  value       = aws_cloudfront_distribution.distribution.domain_name
}

output "s3_url" {
  description = "S3 hosting URL (HTTP)"
  value       = aws_s3_bucket_website_configuration.hosting.website_endpoint
}

output "certificate_arn" {
  description = "ACM Certificate ARN"
  value       = aws_acm_certificate.certificate.arn
}

output "route53_zone_id" {
  description = "Route 53 Zone ID"
  value       = data.aws_route53_zone.main.zone_id
}
