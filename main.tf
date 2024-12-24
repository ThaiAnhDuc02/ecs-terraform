module "infrastructure" {
  source = "./modules/infrastructure"

  # Input
  subnet_db             = local.subnet_db
  subnet_db_1_cidr      = local.subnet_db_1_cidr
  subnet_db_2_cidr      = local.subnet_db_2_cidr
  subnet_private_1_cidr = local.subnet_private_1_cidr
  subnet_private_2_cidr = local.subnet_private_2_cidr
  subnet_public_1_cidr  = local.subnet_public_1_cidr
  subnet_public_2_cidr  = local.subnet_public_2_cidr
  author                = local.author
  network_root_name     = local.network_root_name
  region                = local.region
  subnet_private        = local.subnet_private
  subnet_public         = local.subnet_public
  vpc_cidr              = local.vpc_cidr
}

module "security" {
  source = "./modules/security"

  # Input
  author            = local.author
  vpc_id            = module.infrastructure.vpc_id
  network_root_name = local.network_root_name
  region            = local.region
}

module "compute" {
  source = "./modules/compute"

  # Input
  author             = local.author
  vpc_id             = module.infrastructure.vpc_id
  network_root_name  = local.network_root_name
  region             = local.region
  public_subnet_1_id = module.infrastructure.subnet_public_1_id
  public_subnet_2_id = module.infrastructure.subnet_public_1_id
  key_name           = local.key_name
  security_group_ids = [module.security.public_sg_id]
  compute_root_name  = local.compute_root_name
  ec2_role           = module.role.ec2_role
}

module "role" {
  source = "./modules/role"

  #Input
  author            = local.author
  region            = local.region
  network_root_name = local.network_root_name
}

module "rds" {
  source = "./modules/rds"
  # Input
  author             = local.author
  region             = local.region
  vpc_id             = module.infrastructure.vpc_id
  network_root_name  = local.network_root_name
  subnet_db_1_id     = module.infrastructure.subnet_db_1_id
  subnet_db_2_id     = module.infrastructure.subnet_db_2_id
  db_name            = local.db_name
  db_password        = local.db_password
  db_username        = local.db_username
  security_group_ids = [module.security.db_sg_id]
}

module "cloud_map" {
  source                           = "./modules/cloudmap"
  author                           = local.author
  region                           = local.region
  vpc_id                           = module.infrastructure.vpc_id
  service_discovery_namespace_name = local.service_discovery_namespace_name
  service_discovery_service_name   = local.service_discovery_service_name
}

module "alb" {
  source = "./modules/alb"
  # Input
  author            = local.author
  region            = local.region
  target_group_name = local.target_group_name
  alb_name          = local.alb_name
  vpc_id            = module.infrastructure.vpc_id
  subnet_ids        = [module.infrastructure.subnet_public_1_id, module.infrastructure.subnet_public_2_id]
  security_group_id = module.security.public_sg_id
}

module "ecs" {
  source = "./modules/ecs"
  # Input
  compute_root_name = local.compute_root_name
  ecs_cluster_name = local.cluster_name
  author           = local.author
  region           = local.region

  frontend_family = local.frontend_family
  frontend_image  = local.frontend_image
  be_host         = local.be_host

  backend_family = local.backend_family
  backend_image  = local.backend_image
  mysql_database = local.mysql_database
  db_dialect     = "mysql"
  be_port        = "5000"
  jwt_secret     = "0bac010eca699c25c8f62ba86e319c2305beb94641b859c32518cb854addb5f4"
  db_username    = local.db_username
  db_password    = local.db_password
  db_host        = module.rds.db_instance_endpoint
  execution_role_arn = module.role.ecs_execution_role_arn
}
