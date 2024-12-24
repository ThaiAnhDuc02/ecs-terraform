variable "vpc_id" {
  description = "Id of VPC"
  type = string
}

variable "author" {
  description = "Author create resource"
  type = string
}

variable "network_root_name" {
  description = "Name of network"
  type = string
}

variable "region" {
  description = "region name"
  type = string
}

variable "db_username" {
  description = "db_username"
  type = string
}

variable "db_password" {
  description = "db_password"
  type = string
}

variable "db_name" {
  description = "db_name"
  type = string
}

variable "security_group_ids" {
  description = "List of SG Ids"
  type = set(string)
}

variable "subnet_db_1_id" {
  description = "subnet for rds"
  type = string
}

variable "subnet_db_2_id" {
  description = "subnet for rds"
  type = string
}