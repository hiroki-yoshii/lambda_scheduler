# lambda_scheduler

## 説明
AWSでのバッチ処理を想定した開発のテンプレート

EventBridge+Lambdaを使用し、外部APIのレスポンス結果をS3に保存します。

![スクリーンショット 2023-12-21 012933](https://github.com/hiroki-yoshii/lambda_scheduler/assets/92834078/d3d1b753-4b62-4fa5-88f0-cade0ba07bb5)

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

## デプロイメントを構成する

1. **Environments作成**

   https://github.com/hiroki-yoshii/lambda_scheduler/settings/environments

   ![スクリーンショット 2023-12-21 015702](https://github.com/hiroki-yoshii/lambda_scheduler/assets/92834078/c4a06a15-3be9-431c-9b62-7c6fe439313b)
    
   - develop // 開発環境
   - stage   // ステージング環境
   - prod    // 本番環境
  
3. **作成したEnvironmentsにシークレットを追加する**

   ![スクリーンショット 2023-12-21 015728](https://github.com/hiroki-yoshii/lambda_scheduler/assets/92834078/9c5188d7-66f3-4bb2-bdff-4daa9b12bceb)

   - AWS_ACCESS_KEY_ID      //アクセスキー
   - AWS_SECRET_ACCESS_KEY　//シークレットキー
   - AWS_REGION             //デプロイするリージョン
   - TERRAFORM_BACKEND_BUCKET //tfstate管理用バケット(作成が必要)
   - TERRAFORM_BACKEND_REGION //tfstate管理用バケットが存在するリージョン

5. **develop/stage/prodブランチにpushする**
