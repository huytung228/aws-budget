resource "aws_lambda_function" "instance_shutdown" {
  filename         = "lambda_function.zip"  # Path to your Lambda function code
  function_name    = "instanceShutdown"
  role             = aws_iam_role.lambda_exec.arn
  handler          = "lambda_function.lambda_handler"
  source_code_hash = filebase64sha256("lambda_function.zip")
  runtime          = "python3.8"

  environment {
    variables = {
      INSTANCE_REGION = "us-east-1"  # Change this to your instance region
    }
  }
}
