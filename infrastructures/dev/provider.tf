terraform {
    // tfstate(Terraformの状態を管理するファイル)をS3で管理する
    backend "s3" {
    bucket = var.state_s3_bucket
    key    = var.state_key
    }
}