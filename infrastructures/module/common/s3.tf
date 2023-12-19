# S3バケット
resource "aws_s3_bucket" "original_data_bucket" {
  bucket = "${var.environment}-original-data"
}