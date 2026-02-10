############################################
# ACM Certificate (TLS) for app.dawgs-growl.com
############################################

# Explanation: TLS is the diplomatic passport — browsers trust you, and dawgs stops growling at plaintext.
resource "aws_acm_certificate" "dawgs_acm_cert01" {
  provider                  = aws.use1
  domain_name               = var.domain_name
  subject_alternative_names = ["*.cloudesquire.click"]
  validation_method         = var.certificate_validation_method

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "${var.project_name}-acm-cert01"
  }
}

resource "aws_acm_certificate_validation" "dawgs_acm_validation01" {
  provider        = aws.use1
  certificate_arn = aws_acm_certificate.dawgs_acm_cert01.arn

  validation_record_fqdns = [
    for r in aws_route53_record.dawgs_acm_validation_records01 : r.fqdn
  ]

  timeouts {
    create = "30m"
  }
}

# # Explanation: This ties the “proof record” back to ACM—dawgs gets his green checkmark for TLS.
# resource "aws_acm_certificate_validation" "dawgs_acm_validation01_dns_bonus" {
#   count = var.certificate_validation_method == "DNS" ? 1 : 0

#   certificate_arn = aws_acm_certificate.dawgs_acm_cert01.arn

#   validation_record_fqdns = [
#     for r in aws_route53_record.dawgs_acm_validation_records01 : r.fqdn
#   ]

#   timeouts {
#     create = "30m"  # optional: give more time if propagation is slow
#   }
# }