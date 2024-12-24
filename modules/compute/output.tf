output "aws_instance_id" {
  value = aws_instance.ecs_instance.id
}

output "aws_instance_arn" {
  value = aws_instance.ecs_instance.arn
}

output "aws_instance_public_ip" {
  value = aws_instance.ecs_instance.public_ip
}

output "aws_instance_public_dns" {
  value = aws_instance.ecs_instance.public_dns
}
