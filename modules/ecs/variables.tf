variable "ecs_cluster_name" {
  description = "name of ecs cluster"
  type = string
}

variable "region" {
  description = "Region name of infrastructure"
  type = string
}

variable "author" {
  description = "Creator of this resource"
  type = string
}

# Task def of Backend
variable "backend_family" {
  description = "Name của backend task definition"
  type        = string
}

variable "backend_image" {
  description = "Image của backend container"
  type        = string
}

variable "db_username" {
  description = "Master user of Database"
  type = string
}

variable "db_password" {
  description = "Passowrd of Database Master User"
  type = string
}

variable "mysql_database" {
  description = "MySQL database name"
  type        = string
}

variable "db_host" {
  description = "RDS endpoint"
  type        = string
}

variable "db_dialect" {
  description = "database dialect"
  type        = string
}

variable "be_port" {
  description = "Port of be"
  type        = string
}

variable "jwt_secret" {
  description = "JWT SECRET"
  type        = string
}

# Task def of Frontend
variable "frontend_family" {
  description = "Name của frontend task definition"
  type        = string
}

variable "frontend_image" {
  description = "Image của frontend container"
  type        = string
}

variable "be_host" {
  description = "backend Cloud Map"
  type        = string
}

variable "execution_role_arn" {
  description = "role for task definition"
  type = string
}

variable "compute_root_name" {
  description = "compute root name"
  type = string
}