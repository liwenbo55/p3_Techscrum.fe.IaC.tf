aws_region   = "ap-southeast-2"
project_name = "p3.crankbit"
environment  = "frontend-prod"

hosted_zone_name = "crankbit.com"

domain_name = "crankbit.com"
domain_name_with_www          = "www.crankbit.com"

acm_subject_alternative_names = ["www.crankbit.com"]

cloudfront_distribution_alias = ["crankbit.com", "www.crankbit.com"]
