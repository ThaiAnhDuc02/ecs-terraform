variable "region" {
  description = "Region name of infrastructure"
  type        = string
}

variable "author" {
  description = "creator of this resource"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR Block of VPC"
  type        = string
}

variable "network_root_name" {
  description = "Root name of Network"
  type        = string
}

variable "subnet_private_1_cidr" {
  description = "CIDR Block of Private Subnet 1"
  type        = string
}
variable "subnet_private_2_cidr" {
  description = "CIDR Block of Private Subnet 2"
  type        = string
}
variable "subnet_public_1_cidr" {
  description = "CIDR Block of Public Subnet 1"
  type        = string
}
variable "subnet_public_2_cidr" {
  description = "CIDR Block of Public Subnet 2"
  type        = string
}
variable "subnet_db_1_cidr" {
  description = "CIDR Block of DB subnet 1"
  type        = string
}
variable "subnet_db_2_cidr" {
  description = "CIDR Block of DB subnet 2"
  type        = string
}

variable "subnet_private" {
  description = "subnet for db"
  type        = string
}
variable "subnet_public" {
  description = "subnet for db"
  type        = string
}

variable "subnet_db" {
  description = "name of subnet db"
  type        = string
}