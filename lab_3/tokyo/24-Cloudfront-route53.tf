# Route53 -> CloudFront (root/apex)

data "aws_route53_zone" "dawgs_public_zone" {
  name         = var.domain_name
  private_zone = false
}

# Root domain A record -> CloudFront
resource "aws_route53_record" "dawgs_root_a" {
  allow_overwrite = true

  zone_id = data.aws_route53_zone.dawgs_public_zone.zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.dawgs_cf01.domain_name
    zone_id                = aws_cloudfront_distribution.dawgs_cf01.hosted_zone_id
    evaluate_target_health = false
  }
}

# Root domain AAAA record -> CloudFront (IPv6)
resource "aws_route53_record" "dawgs_root_aaaa" {
  allow_overwrite = true

  zone_id = data.aws_route53_zone.dawgs_public_zone.zone_id
  name    = var.domain_name
  type    = "AAAA"

  alias {
    name                   = aws_cloudfront_distribution.dawgs_cf01.domain_name
    zone_id                = aws_cloudfront_distribution.dawgs_cf01.hosted_zone_id
    evaluate_target_health = false
  }
}

# App subdomain A record -> CloudFront
resource "aws_route53_record" "dawgs_app_a" {
  allow_overwrite = true
  zone_id         = data.aws_route53_zone.dawgs_public_zone.zone_id
  name            = "app.${var.domain_name}"
  type            = "A"

  alias {
    name                   = aws_cloudfront_distribution.dawgs_cf01.domain_name
    zone_id                = aws_cloudfront_distribution.dawgs_cf01.hosted_zone_id
    evaluate_target_health = false
  }
}

# App subdomain AAAA record -> CloudFront
resource "aws_route53_record" "dawgs_app_aaaa" {
  allow_overwrite = true
  zone_id         = data.aws_route53_zone.dawgs_public_zone.zone_id
  name            = "app.${var.domain_name}"
  type            = "AAAA"

  alias {
    name                   = aws_cloudfront_distribution.dawgs_cf01.domain_name
    zone_id                = aws_cloudfront_distribution.dawgs_cf01.hosted_zone_id
    evaluate_target_health = false
  }
}