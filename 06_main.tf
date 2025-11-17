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
    
    az1          = var.az1
    az2          = var.az2
}

module "ecr" {
    source = "./modules/ecr"
    
    project_name = var.project_name
    owner        = var.owner
}