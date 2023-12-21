provider "aws" {
  alias  = "us-east-1"
  region = var.acm_aws_region
}

resource "aws_acm_certificate" "acm_certificate" {
  provider                  = aws.us-east-1
  domain_name               = var.domain_name
  subject_alternative_names = var.subject_alternative_names
  validation_method         = var.validation_method
  key_algorithm             = var.key_algorithm

  tags = {
    Environment = var.environment
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "acm_certificate" {
  depends_on              = [aws_route53_record.validation]
  provider                = aws.us-east-1
  certificate_arn         = aws_acm_certificate.acm_certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.validation : record.fqdn]
}

# ACM validation (add CNAME records to route53)
resource "aws_route53_record" "validation" {
  depends_on = [aws_acm_certificate.acm_certificate]

  zone_id = var.hosted_zone_id

  ttl = var.ACM_validation_ttl

  for_each = {
    for dvo in aws_acm_certificate.acm_certificate.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }
  name    = each.value.name
  records = [each.value.record]
  type    = each.value.type
}
