# Tạo IAM instance profile
resource "aws_iam_instance_profile" "ec2_ecr_profile" {
  name = "ec2_ecr_profile"
  role = var.ec2_role
}

resource "aws_instance" "ecs_instance" {
  ami = "ami-06650ca7ed78ff6fa"
  instance_type = "t2.medium"
  key_name = var.key_name
  subnet_id = var.public_subnet_1_id
  vpc_security_group_ids = var.security_group_ids
  iam_instance_profile = aws_iam_instance_profile.ec2_ecr_profile.name
  user_data = <<-EOF
  #!/bin/bash
    sudo apt update -y
    sudo apt upgrade -y

    # Install Docker dependencies
    sudo apt-get install -y ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc

    # Add Docker repository and install Docker
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    # Install MySQL client
    sudo apt install -y mysql-client

    # Clone Git repository và set quyền cho ubuntu user
    git clone https://github.com/AWS-First-Cloud-Journey/aws-fcj-container-app.git /home/ubuntu/aws-fcj-container-app
    chown -R ubuntu:ubuntu /home/ubuntu/aws-fcj-container-app

    # Thêm user ubuntu vào docker group
    usermod -aG docker ubuntu
  EOF

  tags = {
    Name = "${var.compute_root_name}-server"
    Type = "instance"
    author = var.author
  }
}