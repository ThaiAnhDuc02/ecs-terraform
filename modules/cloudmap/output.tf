output "service_discovery_namespace_id" {
  value = aws_service_discovery_private_dns_namespace.sd_namespace.id
}
output "service_discovery_service_id" {
  value = aws_service_discovery_service.sd_service.id
}