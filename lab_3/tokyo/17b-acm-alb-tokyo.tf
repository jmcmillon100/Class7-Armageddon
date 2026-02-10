resource "aws_acm_certificate" "dawgs_alb_cert_tokyo01" {
  domain_name       = var.domain_name
  validation_method = var.certificate_validation_method

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "${var.project_name}-alb-cert-tokyo01"
  }
}

resource "aws_acm_certificate_validation" "dawgs_alb_cert_tokyo_validation01" {
  certificate_arn         = aws_acm_certificate.dawgs_alb_cert_tokyo01.arn
  validation_record_fqdns = [for r in aws_route53_record.dawgs_acm_validation_records01 : r.fqdn]
}