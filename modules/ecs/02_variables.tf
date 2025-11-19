variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "owner" {
  description = "The owner of the project"
  type        = string
}


variable "tg_arn" {
  description = "The ARN of the target group"
  type        = string
}

variable "launch_type" {
  description = "The launch type for the ECS service"
  type = object({
    type   = string
    cpu    = string
    memory = string
  })
}

variable "subnet_private_ids" {
  description = "The private subnet IDs for the ALB"
  type        = list(string)
}

variable "region" {
  description = "The AWS region"
  type        = string
}

variable "execution_role_arn" {
  description = "The ARN of the ECS task execution role"
  type        = string
}

variable "execution_role_id" {
  description = "The ID of the ECS task execution role"
  type        = string
}

variable "ecs_sg_id" {
  description = "The security group ID for the ECS tasks"
  type        = string
}