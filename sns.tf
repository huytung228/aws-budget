resource "aws_sns_topic" "budget_notifications" {
  name = "budget-notifications"
}

resource "aws_sns_topic_subscription" "lambda_subscription" {
  topic_arn = aws_sns_topic.budget_notifications.arn
  protocol  = "lambda"
  endpoint  = aws_lambda_function.instance_shutdown.arn
}

resource "aws_lambda_permission" "allow_sns" {
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.instance_shutdown.function_name
  principal     = "sns.amazonaws.com"
  source_arn    = aws_sns_topic.budget_notifications.arn
}
