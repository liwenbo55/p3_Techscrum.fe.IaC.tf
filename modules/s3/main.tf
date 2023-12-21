# create s3 bucket for frontend static file
resource "aws_s3_bucket" "s3_bucket_for_frontend" {
  bucket        = "${var.project_name}-${var.domain_name}-${var.environment}"
  force_destroy = var.force_destroy
  tags = {
    Environment = var.environment
  }
}

# attach policy to s3
resource "aws_s3_bucket_policy" "bucket_permission_policy" {
  bucket = aws_s3_bucket.s3_bucket_for_frontend.id
  policy = jsonencode({
    "Version" : "2008-10-17",
    "Id" : "PolicyForCloudFrontPrivateContent",
    "Statement" : [
      {
        "Sid" : "AllowCloudFrontServicePrincipal",
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "cloudfront.amazonaws.com"
        },
        "Action" : "s3:GetObject",
        "Resource" : "${aws_s3_bucket.s3_bucket_for_frontend.arn}/*",
        "Condition" : {
          "StringEquals" : {
            "AWS:SourceArn" : "${var.cloudfront_distribution_arn}"
          }
        }
      }
    ]
    }
  )
}
