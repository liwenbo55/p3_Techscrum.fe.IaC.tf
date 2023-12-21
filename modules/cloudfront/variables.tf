# OAC (Origin access control) variables
variable "origin_access_control_origin_type" {
  default = "s3"
}
variable "signing_behavior" {
  default = "always"
}
variable "signing_protocol" {
  default = "sigv4"
}

variable "domain_name" {
  type = string
}

######## distribution ########
variable "aliases" {
  description = "Alias for cloudfront distribution(e.g. 'abc.com' and 'www.abc.com')"
  type        = list(string)
}

variable "default_root_object" {
  description = "Object that you want CloudFront to return (for example, index.html) when an end user requests the root URL."
}
variable "enabled" {
  description = "Whether the distribution is enabled to accept end user requests for content."
  default     = true
}

variable "is_ipv6_enabled" {
  description = "Whether the IPv6 is enabled for the distribution."
  default     = true
}

variable "price_class" {
  description = "Price class for this distribution."
  default     = "PriceClass_All"
}

# origin config
variable "origin_domain_name" {
  description = "DNS domain name of S3 bucket. (s3_bucket_regional_domain_name)"
}
variable "origin_id" {
  description = "Unique identifier for the origin. (s3_bucket_regional_domain_name)"
}
variable "connection_attempts" {
  description = "Number of times that CloudFront attempts to connect to the origin. Must be between 1-3. Defaults to 3."
  default     = 3
}
variable "connection_timeout" {
  description = "Number of seconds that CloudFront waits when trying to establish a connection to the origin. Must be between 1-10. Defaults to 10."
  default     = 10
}

# default_cache_behavior
variable "compress" {
  description = "Whether you want CloudFront to automatically compress content."
  type        = bool
  default     = true
}
variable "viewer_protocol_policy" {
  description = "Use this element to specify the protocol that users can use to access the files in the origin specified by TargetOriginId when a request matches the path pattern in PathPattern. One of 'allow-all', 'https-only', or 'redirect-to-https'."
  default     = "redirect-to-https"
}
variable "allowed_methods" {
  description = "Controls which HTTP methods CloudFront processes and forwards to your Amazon S3 bucket."
  type        = list(string)
  default     = ["GET", "HEAD"]
}
variable "cached_methods" {
  description = "Controls whether CloudFront caches the response to requests using the specified HTTP methods."
  type        = list(string)
  default     = ["GET", "HEAD"]
}

variable "cache_policy_id" {
  description = "Unique identifier of the cache policy that is attached to the cache behavior.'CachingOptimized' policy is set by default(id:658327ea-f89d-4fab-a63d-7e88639e58f6)"
  default     = "658327ea-f89d-4fab-a63d-7e88639e58f6"
}

# restrictions
variable "geo_restriction_type" {
  description = "Method that you want to use to restrict distribution of your content by country: 'none', 'whitelist', or 'blacklist'. Default to 'none'."
  type        = string
  default     = "none"
}

# viewer_certificate
variable "acm_certificate_arn" {
  description = "ARN of the AWS Certificate Manager certificate that you wish to use with this distribution. The ACM certificate must be in US-EAST-1."
}

variable "cloudfront_default_certificate" {
  description = "Default to false."
  type        = bool
  default     = false
}

variable "minimum_protocol_version" {
  description = "Minimum version of the SSL protocol that you want CloudFront to use for HTTPS connections. Can only be set if 'cloudfront_default_certificate = false.'. Default to 'TLSv1.2_2021'"
  type        = string
  default     = "TLSv1.2_2021"
}

variable "ssl_support_method" {
  description = "How you want CloudFront to serve HTTPS requests. One of 'vip' or 'sni-only'. Default to sni-only."
  type        = string
  default     = "sni-only"
}


variable "wait_for_deployment" {
  description = "If enabled, the resource will wait for the distribution status to change from 'InProgress' to 'Deployed'. Setting this to false will skip the process. Default: true."
  type        = bool
  default     = true
}

variable "retain_on_delete" {
  description = " Disables the distribution instead of deleting it when destroying the resource through Terraform. If this is set, the distribution needs to be deleted manually afterwards. Default: false."
  type        = bool
  default     = false
}
