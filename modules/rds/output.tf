output "db_instance_id" {
  value = aws_db_instance.rds_instance.id
}

output "db_instance_arn" {
  value = aws_db_instance.rds_instance.arn
}

output "db_instance_identifier" {
  value = aws_db_instance.rds_instance.identifier
}

output "db_instance_endpoint" {
  value = regex("^(.*?):", aws_db_instance.rds_instance.endpoint)[0]
}