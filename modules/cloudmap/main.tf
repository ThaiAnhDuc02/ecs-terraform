resource "aws_service_discovery_private_dns_namespace" "sd_namespace" {
  name = var.service_discovery_namespace_name
  vpc = var.vpc_id
  tags = {
    Name = "services-discovery-namespace"
    Type = "Service-Discovery-Namespace"
    Author = var.author
  }
}

resource "aws_service_discovery_service" "sd_service" {
  name = var.service_discovery_service_name
  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.sd_namespace.id
    dns_records {
      type = "A"
      ttl = 60
    }
  }
  health_check_custom_config {
    failure_threshold = 1
  }
  tags = {
    Name = "services-discovery-service"
    Type = "Service-Discovery-Service"
    author = var.author
  }
}