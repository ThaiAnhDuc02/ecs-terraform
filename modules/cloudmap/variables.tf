variable "service_discovery_namespace_name" {
   description = "Name of Service Discovery Namespace"
  type = string
}

variable "service_discovery_service_name" {
  description = "Name of Service Discovery Service"
  type = string
}
variable "region" {
  description = "Region"
  type        = string
}
variable "vpc_id" {
  description = "ID of VPC"
  type = string
}
variable "author" {
  description = "Creator of this resource"
  type = string
}