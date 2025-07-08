# main.tf

# AWS Provider Configuration
provider "aws" {
  region = "us-east-1"
}

# Output the Lambda function name after deployment
output "lambda_function_name" {
  value = aws_lambda_function.demo_lambda.function_name
}

# Output the ECS cluster name after deployment
output "ecs_cluster_name" {
  value = aws_ecs_cluster.demo_cluster.name
}
