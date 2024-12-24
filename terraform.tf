locals {
  region            = "ap-southeast-1"
  author            = "FCJ-Duke"
  network_root_name = "FCJ-Lab"
  compute_root_name = "FCJ-Lab"
  vpc_cidr          = "10.0.0.0/16"
  # Subnet
  subnet_public_1_cidr  = "10.0.1.0/24"
  subnet_private_1_cidr = "10.0.2.0/24"
  subnet_public_2_cidr  = "10.0.3.0/24"
  subnet_private_2_cidr = "10.0.4.0/24"
  subnet_db_1_cidr      = "10.0.5.0/24"
  subnet_db_2_cidr      = "10.0.6.0/24"
  subnet_public         = "subnet-public"
  subnet_private        = "subnet-private"
  # RDS
  subnet_db   = "subnet-db"
  db_username = "admin"
  db_password = "letmein12345"
  db_name     = "fcjresbar"
  key_name    = "FCJ-Lab-key"
  # Namespace
  service_discovery_namespace_name = "fcjresbar.internal"
  service_discovery_service_name   = "backend"

  # Load Balancer
  target_group_name = "FCJ-Lab-fe-tg"
  alb_name          = "FCJ-Lab-alb"

  # ECS
  cluster_name = "FCJ-Lab-ecs"
  # Task definition of backend
  backend_family = "fcjresbar-task-be"
  backend_image  = "730335321184.dkr.ecr.ap-southeast-1.amazonaws.com/fcjresbar-be:latest"
  mysql_database = "fcjresbar"
  db_dialect     = "mysql"
  be_port        = "5000"
  jwt_secret     = "0bac010eca699c25c8f62ba86e319c2305beb94641b859c32518cb854addb5f4"

  # Task definition of frontend
  frontend_family = "fcjresbar-task-fe"
  frontend_image  = "730335321184.dkr.ecr.ap-southeast-1.amazonaws.com/fcjresbar-fe:latest"
  be_host         = "backend.fcjresbar.internal"

}

# Setup provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = local.region
}