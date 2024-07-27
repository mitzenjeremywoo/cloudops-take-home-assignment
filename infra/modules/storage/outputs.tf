output "id" {
  value = aws_s3_bucket.webapp_bucket.id
}

output "arn" {
  value = aws_s3_bucket.webapp_bucket.arn
}

output "domain" {
  value = aws_s3_bucket.webapp_bucket.bucket_domain_name
}

output "regional-domain" {
  value = aws_s3_bucket.webapp_bucket.bucket_regional_domain_name
}