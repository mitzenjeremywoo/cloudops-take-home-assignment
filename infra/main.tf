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

module "webapp" {
  source = "./modules/eb"
  webapp = var.webapp
}

module "webstorage" {
  source = "./modules/storage"
  webapp = var.webapp
}
