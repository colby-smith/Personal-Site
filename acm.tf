provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}

resource "aws_acm_certificate" "certificate" {
  provider          = aws.us_east_1
  domain_name       = "colby-smith-labs.com"
  subject_alternative_names = ["www.colby-smith-labs.com"]
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "certificate_validation" {
  provider = aws.us_east_1
  for_each = { 
    for item in aws_acm_certificate.certificate.domain_validation_options : item.domain_name => {
      name    = item.resource_record_name
      type    = item.resource_record_type
      record  = item.resource_record_value
      ttl      = 60
      zone_id  = data.aws_route53_zone.main.zone_id
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.main.zone_id
}