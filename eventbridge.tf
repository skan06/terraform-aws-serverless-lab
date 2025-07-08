# eventbridge.tf

# Create a rule to trigger Lambda every 5 minutes
resource "aws_cloudwatch_event_rule" "lambda_every_5_min" {
  name                = "lambda-every-5min"
  schedule_expression = "rate(5 minutes)"
}

# Set Lambda as the target for the EventBridge rule
resource "aws_cloudwatch_event_target" "lambda_target" {
  rule      = aws_cloudwatch_event_rule.lambda_every_5_min.name
  target_id = "lambda"
  arn       = aws_lambda_function.demo_lambda.arn
}

# Give EventBridge permission to invoke the Lambda
resource "aws_lambda_permission" "allow_eventbridge_invoke" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.demo_lambda.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.lambda_every_5_min.arn
}
