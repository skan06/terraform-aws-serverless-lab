# ecs.tf

# Create ECS cluster
resource "aws_ecs_cluster" "demo_cluster" {
  name = "demo-cluster"
}

# Create a CloudWatch Log Group for ECS
resource "aws_cloudwatch_log_group" "ecs_log_group" {
  name              = "/ecs/demo-app"
  retention_in_days = 7
}

# Define ECS task using Fargate to run a container
resource "aws_ecs_task_definition" "demo_task" {
  family                   = "demo-task"
  cpu                      = "256"
  memory                   = "512"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name      = "demo-container",
      image     = "amazonlinux", # Lightweight test container
      essential = true,
      command   = ["sh", "-c", "while true; do echo 'Hello from ECS Fargate!' && sleep 30; done"],
      logConfiguration = {
        logDriver = "awslogs",
        options = {
          "awslogs-group"         = "/ecs/demo-app",
          "awslogs-region"        = "us-east-1",
          "awslogs-stream-prefix" = "ecs"
        }
      }
    }
  ])
}

# Deploy ECS service using the task definition
resource "aws_ecs_service" "demo_service" {
  name            = "demo-service"
  cluster         = aws_ecs_cluster.demo_cluster.id
  task_definition = aws_ecs_task_definition.demo_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = [aws_subnet.public1.id, aws_subnet.public2.id]
    security_groups = [aws_security_group.ecs_sg.id]
    assign_public_ip = true
  }
}
