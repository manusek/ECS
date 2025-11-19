variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "owner" {
  description = "The owner of the project"
  type        = string
}


variable "default_cidr" {
  description = "The default CIDR block for the network"
  type        = string
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

# Subnets
variable "subnet_cidr1" {
  description = "The CIDR block for the subnets"
  type        = string
}

variable "subnet_cidr2" {
  description = "The CIDR block for the subnets"
  type        = string
}

variable "subnet_cidr3" {
  description = "The CIDR block for the subnets"
  type        = string
}

variable "subnet_cidr4" {
  description = "The CIDR block for the subnets"
  type        = string
}

# Availability Zones
variable "az1" {
  description = "The first availability zone"
  type        = string
}

variable "az2" {
  description = "The second availability zone"
  type        = string
}
