terraform {
  provider "aws" {}
    backend "s3" {
    bucket = var.state_s3_bucket
    key    = var.state_key
    region = var.aws_region 
    }
}