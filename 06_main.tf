# Network 
module "network" {
  source = "./modules/network"

  project_name = var.project_name
  owner        = var.owner

  default_cidr = var.default_cidr
  vpc_cidr     = var.vpc_cidr
  subnet_cidr1 = var.subnet_cidr1
  subnet_cidr2 = var.subnet_cidr2
  subnet_cidr3 = var.subnet_cidr3
  subnet_cidr4 = var.subnet_cidr4

  az1 = var.az1
  az2 = var.az2
}

# ECR
module "ecr" {
  source = "./modules/ecr"

  project_name = var.project_name
  owner        = var.owner
}

# Security Groups
module "sg" {
  source = "./modules/sg"

  project_name = var.project_name
  owner        = var.owner

  vpc_id       = module.network.vpc_id
  default_cidr = var.default_cidr
}

# Application Load Balancer
module "alb" {
  source = "./modules/alb"

  project_name = var.project_name
  owner        = var.owner

  vpc_id            = module.network.vpc_id
  subent_public_ids = module.network.subnet_public_ids
  alb_sg_id         = module.sg.alb_sg_id
}

# IAM Roles
module "roles" {
  source = "./modules/roles"

  project_name = var.project_name
  owner        = var.owner
}

# ECS
module "ecs" {
  source = "./modules/ecs"

  project_name = var.project_name
  owner        = var.owner

  tg_arn             = module.alb.tg_arn
  execution_role_arn = module.roles.execution_role_arn
  execution_role_id  = module.roles.execution_role_id

  region             = var.aws_region
  subnet_private_ids = module.network.subnet_private_ids
  ecs_sg_id          = module.sg.ecs_sg_id
  launch_type        = var.launch_type
}

# Auto Scaling
module "auto_scaling" {
  source = "./modules/auto-scaling"

  project_name = var.project_name
  owner        = var.owner

  ecs_cluster_name = module.ecs.ecs_cluster_name
  ecs_service_name = module.ecs.ecs_service_name
}