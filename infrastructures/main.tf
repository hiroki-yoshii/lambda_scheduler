# プロバイダー設定ファイル
provider "aws" {

# Todo環境変数化
  access_key = "mock_access_key"
  secret_key = "mock_secret_key"
  region     = "us-east-1"
  s3_use_path_style           = true
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  # 向き先はLocalStackコンテナのドメインを設定
  endpoints {
    lambda = "http://localstack:4566"
    s3     = "http://localstack:4566"
    iam    = "http://localstack:4566"
    events = "http://localstack:4566"
  }
}