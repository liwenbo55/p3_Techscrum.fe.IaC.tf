output "cloudfront_distribution_arn" {
  value = aws_cloudfront_distribution.s3_cloudfront.arn
}

output "cloudfront_distribution_domain_name" {
  value = aws_cloudfront_distribution.s3_cloudfront.domain_name
}

output "cloudfront_distribution_hosted_zone_id" {
  value = aws_cloudfront_distribution.s3_cloudfront.hosted_zone_id
}
