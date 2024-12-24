resource "aws_security_group" "public_sg" {
  description = "Allow access to server"
  vpc_id = var.vpc_id
  name = "${var.network_root_name}-public-sg"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  ingress {
    from_port = 5000
    to_port = 5000
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  ingress {
    from_port = 3000
    to_port = 3000
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    cidr_blocks = [ "0.0.0.0/0" ]
    protocol = "-1"
  }
  tags = {
    Name = "${var.network_root_name}-public-sg"
    Type = "Security group"
    author = var.author
  }
}

### Setup Security group private

resource "aws_security_group" "private_sg" {
    name = "${var.network_root_name}-private-sg"
  description = "Allow server access to public internet"
  vpc_id = var.vpc_id

  ingress {
    security_groups = [ aws_security_group.public_sg.id ]
    protocol = "-1"
    from_port = 0
    to_port = 0
  }
  tags = {
    Name = "${var.network_root_name}-private-sg"
    Type = "Security group"
    author = var.author
  }
}

resource "aws_vpc_security_group_ingress_rule" "private_sg_inbound_2" {
  security_group_id = aws_security_group.private_sg.id
  ip_protocol = "-1"
  cidr_ipv4 = "0.0.0.0/0"
}
resource "aws_vpc_security_group_ingress_rule" "private_sg_inbound_3" {
  security_group_id = aws_security_group.private_sg.id
  referenced_security_group_id = aws_security_group.db_sg.id
  ip_protocol = "-1"
}

### Setup Secutiry group for DB

resource "aws_security_group" "db_sg" {
  name = "${var.network_root_name}-db-sg"
  description = "Allow server access to database server"
  vpc_id = var.vpc_id
  ingress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    security_groups = [ aws_security_group.public_sg.id ]
  }
  ingress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    security_groups = [ aws_security_group.private_sg.id ]
  }
  egress {
    cidr_blocks = [ "0.0.0.0/0" ]
    from_port = 0
    to_port = 0 
    protocol = "-1"
  }
  tags = {
    Name = "${var.network_root_name}-db-sg"
    Type = "Security group"
    author = var.author
  }
}
