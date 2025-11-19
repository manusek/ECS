variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "owner" {
  description = "The owner of the project"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "alb_sg_id" {
  description = "The security group ID for the ALB"
  type        = string
}

variable "subent_public_ids" {
  description = "The public subnet IDs for the ALB"
  type        = list(string)
}