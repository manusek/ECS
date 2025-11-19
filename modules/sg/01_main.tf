# Secutiry Group for ALB
resource "aws_security_group" "alb_sg" {
  name   = "${var.project_name}-alb_sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.default_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.default_cidr]
  }

  tags = {
    Name    = "${var.project_name}-alb_sg"
    Project = var.project_name
    Owner   = var.owner
  }
}

# Security Group for ECS
resource "aws_security_group" "ecs_sg" {
  name   = "${var.project_name}-ecs_sg"
  vpc_id = var.vpc_id

  ingress {
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "${var.project_name}-ecs_sg"
    Project = var.project_name
    Owner   = var.owner
  }
}


