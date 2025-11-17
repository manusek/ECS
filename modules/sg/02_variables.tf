variable "project_name" {
    description = "The name of the project"
    type        = string
}

variable "owner" {
  description = "The owner of the project"
  type = string
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "default_cidr" {
  description = "The default CIDR block for the security group"
  type = string
}