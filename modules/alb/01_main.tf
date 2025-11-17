# LISTENER

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.public.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg.arn
  }
}


# APPLICATION LOAD BALANCER

resource "aws_lb" "public" {
  name               = "${var.project_name}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_sg_id]
  subnets            = [for subnet_id in var.subent_public_ids : subnet_id]


  enable_deletion_protection = true

    #   access_logs {
    #     bucket  = aws_s3_bucket.lb_logs.id
    #     prefix  = "test-lb"
    #     enabled = true
    #   }

  tags = {
    Name    = "${var.project_name}-ecr"
    Project = var.project_name
    Owner   = var.owner
  }
}


# TARGET GROUP

resource "aws_lb_target_group" "alb_tg" {
  name        = "${var.project_name}-alb-tg"
  target_type = "ip"      
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = var.vpc_id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

