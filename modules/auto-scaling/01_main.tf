resource "aws_appautoscaling_target" "ecs_target" {
  max_capacity       = 3
  min_capacity       = 1
  resource_id        = "service/${var.ecs_cluster_name}/${var.ecs_service_name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"

  tags = {
    Name    = "${var.project_name}-ecs_autoscaling_target"
    Project = var.project_name
    Owner   = var.owner
  }
}

# Scale Out Policy
resource "aws_appautoscaling_policy" "ecs_scale_out" {
  name               = "ecs_scale_out"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ecs_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_target.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }

    target_value       = 50
    scale_out_cooldown = 30
    scale_in_cooldown  = 60
  }
}

# Scale In Policy
resource "aws_appautoscaling_policy" "ecs_scale_in" {
  name               = "ecs_scale_in"
  policy_type        = "StepScaling"
  resource_id        = aws_appautoscaling_target.ecs_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_target.service_namespace

  step_scaling_policy_configuration {
    adjustment_type = "ChangeInCapacity"

    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment          = -1
    }

    cooldown = 60
  }
}

resource "aws_cloudwatch_metric_alarm" "ecs_scale_in_alarm" {
  alarm_name          = "ecs-low-cpu"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 1
  period              = 300 # 5 minutes
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  statistic           = "Average"
  threshold           = 25

  dimensions = {
    ClusterName = var.ecs_cluster_name
    ServiceName = var.ecs_service_name
  }

  alarm_actions = [
    aws_appautoscaling_policy.ecs_scale_in.arn
  ]
}