variable "acm_aws_region" {
  description = "ACM region must be in us-east-1 (N.Virginia), if not, ACM will not work."
  default     = "us-east-1"
}

variable "domain_name" {
  type = string
}

variable "subject_alternative_names" {
  description = "A list of domains that should be SANs in the issued certificate."
  type        = list(string)
}

variable "hosted_zone_id" {
  description = "The ID of the route53 hosted zone to contain these CNAME records. Generally, hosted zone should be created before terraform provision."
  type        = string
}

variable "validation_method" {
  description = "validation_method is set to 'DNS' by default."
  type        = string
  default     = "DNS"
}

variable "key_algorithm" {
  description = "key_algorithm is set to 'RSA_2048' by default."
  type        = string
  default     = "RSA_2048"
}

variable "environment" {
  type = string
}

variable "ACM_validation_ttl" {
  description = "validation ttl is set to '300' by default."
  default     = 300
}
