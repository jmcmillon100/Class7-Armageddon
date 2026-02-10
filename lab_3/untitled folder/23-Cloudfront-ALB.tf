resource "aws_cloudfront_distribution" "dawgs_cf01" {
  enabled         = true
  is_ipv6_enabled = true
  comment         = "${var.project_name}-cf01"

  origin {
    origin_id   = "${var.project_name}-alb-origin01"
    domain_name = "origin.${var.domain_name}"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }

    # CloudFront whispers the growl to ALB
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

    cache_policy_id          = data.aws_cloudfront_cache_policy.dawgs_caching_disabled01.id
    origin_request_policy_id = aws_cloudfront_origin_request_policy.dawgs_orp_api01.id
  }
  ordered_cache_behavior {
    path_pattern           = "/api/*"
    target_origin_id       = "${var.project_name}-alb-origin01"
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
    cached_methods  = ["GET", "HEAD"]

    cache_policy_id          = data.aws_cloudfront_cache_policy.dawgs_caching_disabled01.id
    origin_request_policy_id = aws_cloudfront_origin_request_policy.dawgs_orp_api01.id
  }
  ordered_cache_behavior {
    path_pattern           = "/static/*"
    target_origin_id       = "${var.project_name}-alb-origin01"
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = ["GET", "HEAD"]
    cached_methods  = ["GET", "HEAD"]

    cache_policy_id            = aws_cloudfront_cache_policy.dawgs_cache_static01.id
    origin_request_policy_id   = aws_cloudfront_origin_request_policy.dawgs_orp_static01.id
    response_headers_policy_id = aws_cloudfront_response_headers_policy.dawgs_rsp_static01.id
  }

  web_acl_id = aws_wafv2_web_acl.dawgs_cf_waf01.arn

  aliases = [
    var.domain_name,
    var.app_subdomain[0],
  ]

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

