provider "aws" {
}

terraform {
  # S3バックエンドの設定
  backend "s3" {
  }
}
