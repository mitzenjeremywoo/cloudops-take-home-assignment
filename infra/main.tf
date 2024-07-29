terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
}

# vpc
module "webapp_vpc" {
  source = "./modules/vpc"
  vpc    = var.vpc
}

# elastic beanstalk 
module "webapp" {
  source              = "./modules/eb"
  webapp              = var.webapp
  partition           = var.partition
  vpc_id              = module.webapp_vpc.id
  application_subnets = [module.webapp_vpc.public_subnet_id]
}

# storage for deployment
module "webstorage" {
  source = "./modules/storage"
  webapp = var.webapp
}