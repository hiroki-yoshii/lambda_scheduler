# Lambda関数
resource "aws_lambda_function" "fetchAPI_Lambda" {
  function_name = "${var.environment}-APIFetch_Lambda"
  filename         = "/src/lambda_function.zip"
  source_code_hash = filebase64sha256("/src/lambda_function.zip")
  runtime = "python3.11"
  handler = "lambda_function.lambda_handler"
  role = aws_iam_role.fetchAPI_Lambda_exec_role.arn
}

# Lambda実行ロール
resource "aws_iam_role" "fetchAPI_Lambda_exec_role" {
  name = "${var.environment}-APIFetch_Lambda_exec_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        },
      },
    ],
  })
}

# LambdaからS3に対してのPUTポリシー
resource "aws_iam_role_policy" "fetchAPI_Lambda_s3_access" {
  name = "${var.environment}-fetchAPI_Lambda_s3_access"
  role = aws_iam_role.fetchAPI_Lambda_exec_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "s3:PutObject"
        ],
        Effect = "Allow",
        Resource = "${aws_s3_bucket.original_data_bucket.arn}/*"
      }
    ]
  })
}