### ECR Role

resource "aws_iam_role" "ec2_role" {
  name               = "${var.network_root_name}-ec2-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "ec2_ecr_push_policy" {
  name   = "${var.network_root_name}-ec2-ecr-push-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ecr:GetAuthorizationToken"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "ecr:BatchCheckLayerAvailability",
          "ecr:InitiateLayerUpload",
          "ecr:PutImage",
          "ecr:UploadLayerPart", 
          "ecr:CompleteLayerUpload",
          "ecr:ListImages",
          "ecr:DescribeRepositories",
          "ecr:CreateRepository"
        ]
        Resource = "*"  
      }
    ]
  })
}
resource "aws_iam_role_policy_attachment" "ec2_ecr_push_policy_attach" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.ec2_ecr_push_policy.arn
}


### CodeDeployRole
resource "aws_iam_role" "code_deploy_role" {
  name = "CodeDeployRoleForECS"

  assume_role_policy = jsonencode(
    {
      Version: "2012-10-17",
      Statement = [
        {
          Effect = "Allow"
          Principal = {
            Service = "codedeploy.amazonaws.com"
          },
          Action = "sts:AssumeRole"
        }
      ]
    }
  )
}
resource "aws_iam_role_policy_attachment" "attach_codedeploy_policy" {
  role = aws_iam_role.code_deploy_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeDeployRoleForECS"
}

resource "aws_iam_role" "ecs_execution_role" {
  name = "ecs-execution-role"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
        Effect    = "Allow"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_execution_role_policy" {
  role       = aws_iam_role.ecs_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
