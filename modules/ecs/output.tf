# Output
output "cluster_id" {
  value = aws_ecs_cluster.ecs_cluster.id
}
output "cluster_arn" {
  value = aws_ecs_cluster.ecs_cluster.arn
}

output "backend_task_definition_id" {
  value = aws_ecs_task_definition.backend_task_definition.id
}

output "backend_task_definition_arn" {
  value = aws_ecs_task_definition.backend_task_definition.arn
}

output "frontend_task_definition_id" {
  value = aws_ecs_task_definition.frontend_task_definition.id
}

output "frontend_task_definition_arn" {
  value = aws_ecs_task_definition.frontend_task_definition.arn
}