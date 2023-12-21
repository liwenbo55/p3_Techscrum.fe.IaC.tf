output "acm_certificate" {
  value = aws_acm_certificate.acm_certificate
}

output "acm_certificate_arn" {
  value = aws_acm_certificate.acm_certificate.arn
}
