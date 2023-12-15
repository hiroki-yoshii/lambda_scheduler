# EventBridgeルール
resource "aws_cloudwatch_event_rule" "lambda_schedule" {
  name                = "lambda-schedule-rule"
  description         = "Trigger Lambda on a schedule"
  schedule_expression = "rate(5 minutes)"  # 5分ごとに実行。
}
# ルールの向き先を設定
resource "aws_cloudwatch_event_target" "lambda" {
  rule      = aws_cloudwatch_event_rule.lambda_schedule.name
  target_id = "HelloWorldTarget"
  arn       = aws_lambda_function.test_lambda.arn
}
# Lambda実行用の権限
resource "aws_lambda_permission" "allow_cloudwatch" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.test_lambda.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.lambda_schedule.arn
}
