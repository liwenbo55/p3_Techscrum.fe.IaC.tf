## a_record_for_cloudfront
variable "hosted_zone_id" {
  description = "The ID of the route53 hosted zone to contain CNAME records. Generally, hosted zone should be created before terraform provision."
  type        = string
}
variable "record_domain_name" {
  description = "The name of the record. (domain_name)"
  type        = string
}
variable "record_type_A" {
  description = "The record type for domain traffic to cloudfront distribution (alias). "
  type        = string
  default     = "A"
}

# alias
variable "cloudfront_distribution_domain_name" {
  description = "DNS domain name for CloudFront distribution"
}
variable "cloudfront_distribution_hosted_zone_id" {
  description = "Hosted zone ID for CloudFront distribution"
}
variable "evaluate_target_health" {
  type    = bool
  default = false
}

## cname_record
# This cname record is to traffic domain_name_with_www to domain_name (e.g. Traffic 'www.abc.com' to 'abc.com')
variable "domain_name_with_www" {
  description = "Traffic domain name with 'www.' to bare domain. e.g. Traffic 'www.abc.com' to 'abc.com'"
  type        = string
}
variable "record_type_CNAME" {
  description = "CNAME record to traffic domain name with 'www.' to bare domain."
  type        = string
  default     = "CNAME"
}
variable "ttl" {
  description = "The TTL of the record. Default to 300."
  type        = string
  default     = "300"
}
