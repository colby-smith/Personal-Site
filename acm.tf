provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}

resource "aws_acm_certificate" "certificate" {
  provider          = aws.us_east_1
  domain_name       = "colby-smith-labs.com"
  validation_method = "DNS"
}

resource "aws_route53_record" "certificate_validation" {
  provider = aws.us_east_1  # ACM certificate validation must be done in us-east-1

  for_each = { for option in aws_acm_certificate.certificate.domain_validation_options : option.domain_name => option }

  name    = each.value.resource_record_name
  type    = each.value.resource_record_type
  zone_id  = data.aws_route53_zone.main.zone_id
  records  = [each.value.resource_record_value]
  ttl      = 60
}
