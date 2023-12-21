variable "aws_region" {
  description = "aws_region"
  type        = string
}

variable "environment" {
  description = "define the environment"
  type        = string
}

variable "project_name" {
  description = "define the project name"
  type        = string
}

variable "domain_name" {
  description = "domain name for the project(without 'www')"
  type        = string
}

variable "hosted_zone_name" {
  description = "The name of the route53 hosted zone to contain CNAME records. Generally, hosted zone should be created before terraform provision."
  type        = string
}

variable "domain_name_with_www" {
  description = "Domain name for the project(with 'www'). Default to null."
  type        = string
  default     = ""
}

variable "acm_subject_alternative_names" {
  description = "A list of domains that should be SANs(subject_alternative_names) in the issued certificate. Default to null. （Set to '[]' if no SANs）"
  type        = list(string)
  default     = []
}

variable "cloudfront_distribution_alias" {
  description = "Alternate domain name(Alias) for cloudfront distribution(including 'abc.com' and 'www.abc.com')."
  type        = list(string)
}
