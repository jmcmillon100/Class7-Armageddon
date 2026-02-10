############################################
# CloudFront Policies (dawgs)
############################################

# Managed policy: caching disabled (good default for APIs)
data "aws_cloudfront_cache_policy" "dawgs_caching_disabled01" {
  name = "Managed-CachingDisabled"
}

# API: forward everything that matters (headers, cookies, query strings)
resource "aws_cloudfront_origin_request_policy" "dawgs_orp_api01" {
  name    = "${var.project_name}-orp-api01"
  comment = "Forward all viewer headers/cookies/query strings (API)"

  headers_config {
    header_behavior = "allViewer"
  }

  cookies_config {
    cookie_behavior = "all"
  }

  query_strings_config {
    query_string_behavior = "all"
  }
}

# Static: only forward what is typically safe/minimal
resource "aws_cloudfront_origin_request_policy" "dawgs_orp_static01" {
  name    = "${var.project_name}-orp-static01"
  comment = "Minimal forwarding for static"

  headers_config {
    header_behavior = "none"
  }

  cookies_config {
    cookie_behavior = "none"
  }

  query_strings_config {
    query_string_behavior = "none"
  }
}

# Static cache policy: cache hard
resource "aws_cloudfront_cache_policy" "dawgs_cache_static01" {
  name    = "${var.project_name}-cache-static01"
  comment = "Cache static objects"

  default_ttl = 86400    # 1 day
  max_ttl     = 31536000 # 1 year
  min_ttl     = 0

  parameters_in_cache_key_and_forwarded_to_origin {
    enable_accept_encoding_gzip   = true
    enable_accept_encoding_brotli = true

    cookies_config {
      cookie_behavior = "none"
    }

    headers_config {
      header_behavior = "none"
    }

    query_strings_config {
      query_string_behavior = "none"
    }
  }
}

# Static response headers policy (basic security headers)
resource "aws_cloudfront_response_headers_policy" "dawgs_rsp_static01" {
  name    = "${var.project_name}-rsp-static01"
  comment = "Security headers for static responses"

  security_headers_config {
    content_type_options {
      override = true
    }

    frame_options {
      frame_option = "DENY"
      override     = true
    }

    referrer_policy {
      referrer_policy = "same-origin"
      override        = true
    }

    xss_protection {
      protection = true
      mode_block = true
      override   = true
    }
  }
}
