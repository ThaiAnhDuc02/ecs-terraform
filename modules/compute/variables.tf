variable "region" {
  description = "Region"
  type        = string
}
variable "public_subnet_1_id" {
  description = "Public subnet for Instance"
  type = string
}

variable "public_subnet_2_id" {
  description = "Public subnet for Instance"
  type = string
}

variable "key_name" {
    description = "Key for security Instance"
    type = string
}

variable "author" {
  description = "Author of resource"
  type = string
}

variable "vpc_id" {
  description = "ID of VPC"
  type = string
}
variable "network_root_name" {
  description = "Name of network"
  type = string
}
variable "compute_root_name" {
  description = "Name of Computing"
  type = string
}
variable "security_group_ids" {
  description = "List of SG Ids"
  type = set(string)
}

variable "ec2_role" {
  description = "attach role ecr"
  type = string
}