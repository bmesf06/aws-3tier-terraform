resource "aws_s3_bucket" "logs" {
  bucket = "proj2-logs-${random_id.suffix.hex}"

  tags = {
    Name = "proj2-logs"
  }
}

# Random suffix to make bucket name globally unique
resource "random_id" "suffix" {
  byte_length = 4
}
