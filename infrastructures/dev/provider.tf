provider "aws" {
}

terraform {
  backend "s3" {
    # S3バックエンドの設定
    bucket = var.state_s3_bucket
    key    = var.state_key
    region = var.aws_region
  }
}
