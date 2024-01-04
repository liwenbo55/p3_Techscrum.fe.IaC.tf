provider "aws" {
  region = var.aws_region
}

data "aws_route53_zone" "hosted_zone" {
  name = var.hosted_zone_name
}

module "s3" {
  source                      = "../../modules/s3"
  project_name                = var.project_name
  environment                 = var.environment
  domain_name                 = var.domain_name
  cloudfront_distribution_arn = module.cloudfront.cloudfront_distribution_arn
}

module "cloudfront" {
  source              = "../../modules/cloudfront"
  domain_name         = var.domain_name
  origin_domain_name  = module.s3.s3_bucket_regional_domain_name
  origin_id           = module.s3.s3_bucket_regional_domain_name
  acm_certificate_arn = module.acm.acm_certificate_arn
  default_root_object = "index.html"
  aliases             = var.cloudfront_distribution_alias
}

module "route53" {
  source                                 = "../../modules/route53"
  hosted_zone_id                         = data.aws_route53_zone.hosted_zone.zone_id
  record_domain_name                     = var.domain_name
  cloudfront_distribution_domain_name    = module.cloudfront.cloudfront_distribution_domain_name
  cloudfront_distribution_hosted_zone_id = module.cloudfront.cloudfront_distribution_hosted_zone_id
  depends_on                             = [module.acm.acm_certificate]
  domain_name_with_www                   = var.domain_name_with_www
}

module "acm" {
  source                    = "../../modules/acm"
  hosted_zone_id            = data.aws_route53_zone.hosted_zone.zone_id
  domain_name               = var.domain_name
  subject_alternative_names = var.acm_subject_alternative_names
  environment               = var.environment
}