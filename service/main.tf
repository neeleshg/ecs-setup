resource "aws_cloudwatch_log_group" "service" {
  name              = var.service_name
  retention_in_days = 1
}

resource "aws_ecs_task_definition" "service" {
  family = var.service_name

  container_definitions = <<EOF
[
  {
    "name": "${var.service_name}_${var.env}_svc",
    "image": "${var.image_path}",
    "cpu": 0,
    "memory": 2048,
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-region": "${var.region}",
        "awslogs-group": "${var.service_name}-${var.env}-svc",
        "awslogs-stream-prefix": "${var.service_name}"
      }
    }
  }
]
EOF
}

resource "aws_ecs_service" "service" {
  name            = "${var.service_name}-${var.env}"
  cluster         = var.cluster_id
  task_definition = aws_ecs_task_definition.service.arn

  desired_count = 1

  deployment_maximum_percent         = 100
  deployment_minimum_healthy_percent = 0
}
