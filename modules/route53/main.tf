# Create A record for cloudfront
resource "aws_route53_record" "a_record_for_cloudfront" {
  zone_id = var.hosted_zone_id
  name    = var.record_domain_name
  type    = var.record_type_A

  alias {
    name                   = var.cloudfront_distribution_domain_name
    zone_id                = var.cloudfront_distribution_hosted_zone_id
    evaluate_target_health = var.evaluate_target_health
  }
}

resource "aws_route53_record" "cname_record_for_www" {
  # if domain_name_with_www is not null, count =1 (will create one resource).
  # if domain_name_with_www is null, count =0 (will not create)
  count   = var.domain_name_with_www != "" ? 1 : 0
  zone_id = var.hosted_zone_id
  name    = var.domain_name_with_www
  type    = var.record_type_CNAME
  ttl     = var.ttl
  records = [var.record_domain_name]
}