resource "aws_budgets_budget" "monthly_cost_budget" {
  name              = "Monthly-Cost-Budget"
  budget_type       = "COST"
  limit_amount      = 100.0
  limit_unit        = "USD"
  time_period_start = "2024-01-01_00:00"
  time_period_end   = "2024-12-31_23:59"
  time_unit         = "MONTHLY"
  
  cost_filter {
    name = "Service"
    values = [
      "Amazon Elastic Compute Cloud - Compute",
    ]
  }

  notification {
    comparison_operator = "GREATER_THAN"
    threshold           = 90
    threshold_type      = "PERCENTAGE"
    notification_type   = "ACTUAL"
    subscriber_email_addresses = ["test@example.com"]
  }
  
  notification {
    comparison_operator = "GREATER_THAN"
    notification_type   = "ACTUAL"
    threshold_type      = "PERCENTAGE"
    threshold           = 80
    subscriber_sns_topic_arns = [aws_sns_topic.budget_notifications.arn]
  }
}