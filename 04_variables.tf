#variables.terraform 

variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "eu-central-1"
}
  
variable "project_name" {
  description = "The name of the project"
  type        = string
  default = "cloudforge"
}

variable "owner" {
  description = "The owner of the project"
  type        = string
  default = "kdlugosz"
}

variable "default_cidr" {
  description = "The default CIDR block for the network"
  type = string
  default = "0.0.0.0/0"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type = string
  default = "192.168.0.0/16"
}

variable "subnet_cidr1" {
  description = "The CIDR block for the subnets"
  type = string
  default = "192.168.10.0/24"
}

variable "subnet_cidr2" {
  description = "The CIDR block for the subnets"
  type = string
  default = "192.168.11.0/24"
}

variable "subnet_cidr3" {
  description = "The CIDR block for the subnets"
  type = string
  default = "192.168.12.0/24"
}

variable "subnet_cidr4" {
  description = "The CIDR block for the subnets"
  type = string
  default = "192.168.13.0/24"
}

variable "az1" {
  description = "The first availability zone"
  type = string
  default = "eu-central-1a"

}

variable "az2" {
  description = "The second availability zone"
  type = string
  default = "eu-central-1b"
}
