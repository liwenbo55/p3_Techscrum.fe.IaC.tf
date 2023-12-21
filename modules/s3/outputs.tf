output "s3_bucket_for_frontend" {
  value = aws_s3_bucket.s3_bucket_for_frontend
}

output "s3_bucket_regional_domain_name" {
  value = aws_s3_bucket.s3_bucket_for_frontend.bucket_regional_domain_name
}
