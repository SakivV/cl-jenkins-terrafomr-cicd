output "cloudfront_distribution_id" {
  value       = aws_cloudfront_distribution.s3_distribution.id
  description = "description"
}

output "cloudfront_distribution_domain" {
  value       = aws_cloudfront_distribution.s3_distribution.domain_name
  description = "description"
}

output "s3_bucket_id" {
  value       = aws_s3_bucket.s3_bucket.id
  description = "description"
}
