# lambda.tf

# Create CloudWatch Log Group for Lambda
resource "aws_cloudwatch_log_group" "lambda_log_group" {
  name              = "/aws/lambda/demo-lambda"
  retention_in_days = 7
}

# Create a Lambda function using Python
resource "aws_lambda_function" "demo_lambda" {
  function_name    = "demo_lambda_function"
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.12"
  filename         = "${path.module}/lambda_function.zip"
  source_code_hash = filebase64sha256("${path.module}/lambda_function.zip")
  role             = aws_iam_role.lambda_exec_role.arn
  # Set environment variables (e.g. S3 bucket name)
  environment {
    variables = {
      BUCKET_NAME = aws_s3_bucket.lambda_output_bucket.bucket
    }
  }

  depends_on = [
    aws_iam_role_policy_attachment.lambda_logs_attach,
    aws_iam_role_policy_attachment.lambda_s3_policy_attach
  ]
}
