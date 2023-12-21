# OAC (Origin access control) config
resource "aws_cloudfront_origin_access_control" "orgin_access_control" {
  name                              = var.domain_name
  origin_access_control_origin_type = var.origin_access_control_origin_type
  signing_behavior                  = var.signing_behavior
  signing_protocol                  = var.signing_protocol
}

# distribution
resource "aws_cloudfront_distribution" "s3_cloudfront" {

  aliases = var.aliases

  origin {
    domain_name = var.origin_domain_name
    origin_id   = var.origin_id

    # Unique identifier of OAC for this origin.
    origin_access_control_id = aws_cloudfront_origin_access_control.orgin_access_control.id

    connection_attempts = var.connection_attempts
    connection_timeout  = var.connection_timeout
  }
  default_root_object = var.default_root_object
  enabled             = var.enabled
  is_ipv6_enabled     = var.is_ipv6_enabled
  price_class         = var.price_class

  default_cache_behavior {
    compress               = var.compress
    viewer_protocol_policy = var.viewer_protocol_policy
    allowed_methods        = var.allowed_methods
    cached_methods         = var.cached_methods
    cache_policy_id        = var.cache_policy_id
    target_origin_id       = var.origin_id
  }
  restrictions {
    geo_restriction {
      restriction_type = var.geo_restriction_type
    }
  }

  viewer_certificate {
    acm_certificate_arn            = var.acm_certificate_arn
    cloudfront_default_certificate = var.cloudfront_default_certificate
    minimum_protocol_version       = var.minimum_protocol_version
    ssl_support_method             = var.ssl_support_method
  }

  # add erroe page
  custom_error_response {
    error_code             = 403
    response_code          = 403
    response_page_path     = "/index.html"
    error_caching_min_ttl  = 10
  }  

  wait_for_deployment = var.wait_for_deployment
  retain_on_delete    = var.retain_on_delete
}
