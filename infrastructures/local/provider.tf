# 向き先はLocalStackコンテナのドメインを設定
locals {
  localstack_endpoint = "http://localstack:4566"
}
# LocalStack用のプロバイダ設定
provider "aws" {
  access_key = "mock_access_key"
  secret_key = "mock_secret_key"
  region     = "us-east-1"
  s3_use_path_style           = true
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    lambda = local.localstack_endpoint
    s3     = local.localstack_endpoint
    iam    = local.localstack_endpoint
    events = local.localstack_endpoint
  }
}