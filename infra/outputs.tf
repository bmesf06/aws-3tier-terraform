output "vpc_id" {
  value       = aws_vpc.main.id
  description = "ID of the main VPC"
}

output "public_alb_dns_name" {
  value       = aws_lb.public_alb.dns_name
  description = "DNS name of the public ALB"
}

output "web_instance_id" {
  value       = aws_instance.web_private_a.id
  description = "ID of the private web instance"
}

output "rds_endpoint" {
  value       = aws_db_instance.app_db.address
  description = "RDS endpoint for the app database"
}

output "logs_bucket_name" {
  value       = aws_s3_bucket.logs.bucket
  description = "S3 bucket for logs"
}
