# EventBridgeルール
resource "aws_cloudwatch_event_rule" "fetchAPI_Lambda_schedule_rule" {
  name                = "fetchAPI_Lambda-schedule-rule"
  description         = "Trigger Fetch API on a schedule"
  schedule_expression = "cron(0/5 * * * ? *)" # Cron式 5分間隔
}
# ルールの向き先を設定
resource "aws_cloudwatch_event_target" "lambda_event_target" {
  rule      = aws_cloudwatch_event_rule.fetchAPI_Lambda_schedule_rule.name
  target_id = "FetchAPILambdaTarget"
  arn       = aws_lambda_function.fetchAPI_Lambda.arn
}
# Lambda実行用の権限
resource "aws_lambda_permission" "allow_cloudwatch" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.fetchAPI_Lambda.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.fetchAPI_Lambda_schedule_rule.arn
}
