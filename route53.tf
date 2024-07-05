data "aws_route53_zone" "main" {
  provider = aws.eu_west_1
  name     = "colby-smith-labs.com."
}

resource "aws_route53_record" "www" {
  provider = aws.eu_west_1

  zone_id  = data.aws_route53_zone.main.zone_id
  name     = "www.colby-smith-labs.com"
  type     = "CNAME"
  ttl      = 300
  records  = [aws_cloudfront_distribution.distribution.domain_name]
}

resource "aws_route53_record" "root" {
  provider = aws.eu_west_1

  zone_id  = data.aws_route53_zone.main.zone_id
  name     = "colby-smith-labs.com"
  type     = "A"
  alias {
    name                   = aws_cloudfront_distribution.distribution.domain_name
    zone_id                = aws_cloudfront_distribution.distribution.hosted_zone_id
    evaluate_target_health = true
  }
}
