# Explanation: CloudFront is the only public doorway — dawgs stands behind it with private infrastructure.
resource "aws_cloudfront_distribution" "dawgs_cf01" {
  enabled         = true
  is_ipv6_enabled = true
  comment         = "${var.project_name}-cf01"

  origin {
    origin_id   = "${var.project_name}-alb-origin01"
    domain_name = aws_lb.dawgs_alb01.dns_name

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }

    # Explanation: CloudFront whispers the secret growl — the ALB only trusts this.
    custom_header {
      name  = "X-dawgs-Growl"
      value = random_password.dawgs_origin_header_value01.result
    }
  }

  default_cache_behavior {
    target_origin_id       = "${var.project_name}-alb-origin01"
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
    cached_methods  = ["GET", "HEAD"]

    # TODO: students choose cache policy / origin request policy for their app type
    # For APIs, typically forward all headers/cookies/querystrings.
    forwarded_values {
      query_string = true
      headers      = ["*"]
      cookies { forward = "all" }
    }
  }

  # Explanation: Attach WAF at the edge — now WAF moved to CloudFront.
  web_acl_id = aws_wafv2_web_acl.dawgs_cf_waf01.arn

  # TODO: students set aliases for zerotrustzone.dev and app.zerotrustzone.dev
  aliases = [
    var.domain_name,
    var.app_subdomain[0]
  ]

  # TODO: students must use ACM cert in us-east-1 for CloudFront
  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate_validation.dawgs_acm_validation01.certificate_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
}

resource "random_password" "dawgs_origin_header_value01" {
  length  = 32
  special = false
}