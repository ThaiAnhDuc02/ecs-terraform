output "code_deploy_role_id" {
  value = aws_iam_role.code_deploy_role.id
}
output "code_deploy_role_arn" {
  value = aws_iam_role.code_deploy_role.arn
}

output "ec2_role" {
  value = aws_iam_role.ec2_role.name
}

output "ecs_execution_role_arn" {
  value = aws_iam_role.ecs_execution_role.arn
}