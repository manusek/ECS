##############
# ECS Cluster
##############

resource "aws_ecs_cluster" "cluster" {
  name = "${var.project_name}-cluster"

  tags = {
    Name    = "${var.project_name}-cluster"
    Project = var.project_name
    Owner   = var.owner
  }
}


##################
# ECS Task Definition
##################  

resource "aws_ecs_task_definition" "api" {
  family                   = "python_hello_world"
  requires_compatibilities = [var.launch_type.type]
  execution_role_arn       = var.execution_role_arn
  network_mode             = "awsvpc"
  cpu                      = var.launch_type.cpu
  memory                   = var.launch_type.memory

  container_definitions = jsonencode([
    {
      name      = "python_hello_world_container"
      image     = "100403449592.dkr.ecr.eu-central-1.amazonaws.com/cloudforge-ecr:latest"
      essential = true

      portMappings = [
        {
          containerPort = 8080
          hostPort      = 8080
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.ecs.name
          awslogs-region        = var.region
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
}

data "aws_ecs_task_definition" "api" {
  task_definition = aws_ecs_task_definition.api.family
}

##################
# Service
##################

resource "aws_ecs_service" "service" {
  name                = "${var.project_name}-service"
  launch_type         = var.launch_type.type
  cluster             = aws_ecs_cluster.cluster.id
  task_definition     = aws_ecs_task_definition.api.arn
  scheduling_strategy = "REPLICA"

  desired_count                      = 1
  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 100

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [var.execution_role_id]

  network_configuration {
    assign_public_ip = false
    subnets          = [for subnet_id in var.subnet_private_ids : subnet_id]
    security_groups  = [var.ecs_sg_id]
  }

  load_balancer {
    target_group_arn = var.tg_arn
    container_name   = "python_hello_world_container"
    container_port   = 8080
  }

}

resource "aws_cloudwatch_log_group" "ecs" {
  name              = "/ecs/python_hello_world_app"
  retention_in_days = 14
}
