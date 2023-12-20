# lambda_scheduler

## 説明
AWSでのバッチ処理を想定した開発のテンプレート

EventBridge+Lambdaを使用し、外部APIのレスポンス結果をS3に保存します。

[
![スクリーンショット 2023-12-21 012812](https://github.com/hiroki-yoshii/lambda_scheduler/assets/92834078/14cd75ff-4b87-495f-9246-b8e2e782a834)
](url)

## 使用技術
- **言語**: 
    - Python3.11
- **クラウドサービス**: 
    - AWS (EventBridge, S3, Lambda)
- **インフラストラクチャプロビジョニング:**
    - Docker Compose  v2.21.0
    - LocalStack v3.0.0
    - Terraform v1.6.5
- **デプロイメント:**
    - GitHub Actions 

## セットアップ

```
docker compose up -d
```

## その他コマンド

**terraformの変更を反映する**

```
docker compose up terraform --build

```
**LocalStackに作成されたS3バケットのオブジェクト一覧を取得する**

```
aws --endpoint-url=http://localhost:4566 s3 ls s3://local-original-data/
```

**Lambdaを手動実行し、APIのレスポンスをS3に保存する**

```
 aws --endpoint-url=http://localhost:4566 --region us-east-1 lambda invoke --function-name "local-APIFetch_Lambda" --no-cli-pager /dev/stdout
```
