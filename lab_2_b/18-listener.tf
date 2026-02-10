############################################
# ALB Listeners: HTTP -> HTTPS redirect, HTTPS -> TG
############################################

# Explanation: HTTP listener is the decoy airlock — it redirects everyone to the secure entrance.
resource "aws_lb_listener" "dawgs_http_listener01" {
  load_balancer_arn = aws_lb.dawgs_alb01.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

# Explanation: HTTPS listener is the real hangar bay — TLS terminates here, then traffic goes to private targets.
resource "aws_lb_listener" "dawgs_https_listener01" {
  load_balancer_arn = aws_lb.dawgs_alb01.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn   = aws_acm_certificate_validation.dawgs_acm_validation01.certificate_arn

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Forbidden"
      status_code  = "403"
    }
  }

  depends_on = [aws_acm_certificate_validation.dawgs_acm_validation01]
}
resource "aws_lb_listener_rule" "dawgs_allow_cloudfront_only01" {
  listener_arn = aws_lb_listener.dawgs_https_listener01.arn
  priority     = 10

  condition {
    http_header {
      http_header_name = "X-dawgs-Growl"
      values           = [random_password.dawgs_origin_header_value01.result]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.dawgs_tg01.arn
  }
}