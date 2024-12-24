resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.ecs_cluster_name
  setting {
    name = "containerInsights"
    value = "enabled"
  }
   tags = {
    Name = "${var.compute_root_name}-ecs-cluster"
    Type = "ECS-Cluster"
    Author = var.author
  }
}

resource "aws_ecs_task_definition" "backend_task_definition" {
    family = var.backend_family
    network_mode = "awsvpc"
    requires_compatibilities = ["FARGATE"]
    cpu = "4096"
    memory = "8192"
    execution_role_arn = var.execution_role_arn
    container_definitions = jsonencode([
        {
            name      = "backend"
            image = var.backend_image
            cpu = 2048
            memory = 4096
            essential = true
            portMappings = [
                {
                containerPort = 5000
                hostPort      = 5000
                protocol      = "tcp"
                }
            ]
            environment = [
                {
                name  = "MYSQL_USER"
                value = var.db_username
                },
                {
                name  = "MYSQL_PASSWORD"
                value = var.db_password
                },
                {
                name  = "MYSQL_DATABASE"
                value = var.mysql_database
                },
                {
                name  = "DB_HOST"
                value = var.db_host
                },
                {
                name  = "DB_DIALECT"
                value = var.db_dialect
                },
                {
                name  = "PORT"
                value = var.be_port
                },
                {
                name  = "JWT_SECRET"
                value = var.jwt_secret
                }
            ]
        }
    ])
    tags = {                                     
    Name = "be-task-definition"
  }
}

resource "aws_ecs_task_definition" "frontend_task_definition" {
  family = var.frontend_family
  network_mode = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu = 2048
  memory = 4096
  execution_role_arn = var.execution_role_arn
  container_definitions = jsonencode([
    {
        name = "frontend"
        image = var.frontend_image
        cpu = 1024
        memory = 2048
        essential = true
        portMappings = [
            {
                containerPort = 80
                hostPort = 80
                protocol = "tcp"
            }
        ]
        environment = [
            {
            name  = "BACKEND_HOST"
            value = var.be_host
            },
            {
            name  = "BACKEND_PORT"
            value = var.be_port
            }
        ]
    }
  ])
  tags = {
    Name = "fe-task-definition"
  }
}