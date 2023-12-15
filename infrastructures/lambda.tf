resource "aws_lambda_function" "test_lambda" {
  function_name = "HelloWorld"

  filename         = "/src/lambda_function.zip"
  source_code_hash = filebase64sha256("/src/lambda_function.zip")

  runtime = "python3.11"
  handler = "lambda_function.lambda_handler"

  role = aws_iam_role.lambda_exec_role.arn
}

resource "aws_iam_role" "lambda_exec_role" {
  name = "lambda_exec_role"

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