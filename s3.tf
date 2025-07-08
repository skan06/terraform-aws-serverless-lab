# s3.tf

# Create a unique S3 bucket for Lambda output
resource "random_id" "bucket_suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "lambda_output_bucket" {
  bucket        = "lambda-logs-bucket-${random_id.bucket_suffix.hex}"
  force_destroy = true
}
