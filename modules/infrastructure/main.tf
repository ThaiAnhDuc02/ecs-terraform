resource "aws_vpc" "ecs_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name   = "${var.network_root_name}-vpc"
    Type   = "VPC"
    author = var.author
  }
}
### Set up subnet
resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.ecs_vpc.id
  cidr_block              = var.subnet_public_1_cidr
  map_public_ip_on_launch = true
  availability_zone       = "${var.region}a"
  tags = {
    Name   = "${var.network_root_name}-${var.subnet_public}1-${var.region}-a"
    Type   = "subnet"
    author = var.author
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.ecs_vpc.id
  cidr_block              = var.subnet_public_2_cidr
  map_public_ip_on_launch = true
  availability_zone       = "${var.region}b"
  tags = {
    Name   = "${var.network_root_name}-${var.subnet_public}2-${var.region}-b"
    Type   = "subnet"
    author = var.author
  }
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id                  = aws_vpc.ecs_vpc.id
  cidr_block              = var.subnet_private_1_cidr
  map_public_ip_on_launch = false
  availability_zone       = "${var.region}a"
  tags = {
    Name   = "${var.network_root_name}-${var.subnet_private}1-${var.region}-a"
    Type   = "subnet"
    author = var.author
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id                  = aws_vpc.ecs_vpc.id
  cidr_block              = var.subnet_private_2_cidr
  map_public_ip_on_launch = false
  availability_zone       = "${var.region}b"
  tags = {
    Name   = "${var.network_root_name}-${var.subnet_private}2-${var.region}-b"
    Type   = "subnet"
    author = var.author
  }
}

resource "aws_subnet" "db_subnet_1" {
  vpc_id                  = aws_vpc.ecs_vpc.id
  cidr_block              = var.subnet_db_1_cidr
  map_public_ip_on_launch = false
  availability_zone       = "${var.region}a"
  tags = {
    Name   = "${var.network_root_name}-${var.subnet_db}1-${var.region}-a"
    Type   = "subnet"
    author = var.author
  }
}

resource "aws_subnet" "db_subnet_2" {
  vpc_id                  = aws_vpc.ecs_vpc.id
  cidr_block              = var.subnet_db_2_cidr
  map_public_ip_on_launch = false
  availability_zone       = "${var.region}b"
  tags = {
    Name   = "${var.network_root_name}-${var.subnet_db}2-${var.region}-b"
    Type   = "subnet"
    author = var.author
  }
}

### Setup internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.ecs_vpc.id
  tags = {
    Name   = "${var.network_root_name}-igw"
    Type   = "Internet Gateway"
    author = var.author
  }
}

### Nat Gateway
resource "aws_eip" "elastic_ip" {
  tags = {
    Name   = "${var.network_root_name}-elastic-ip"
    Type   = "elastic-ip"
    author = var.author
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id     = aws_eip.elastic_ip.id
  subnet_id         = aws_subnet.public_subnet_1.id
  connectivity_type = "public"

  depends_on = [
    aws_internet_gateway.igw
  ]
  tags = {
    Name   = "${var.network_root_name}-NAT-gateway"
    Type   = "nat-gateway"
    author = var.author
  }
}

### Setup routable
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.ecs_vpc.id
  # Local
  route {
    cidr_block = var.vpc_cidr
    gateway_id = "local"
  }
  # Internet
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

 tags = {
   Name = "${var.network_root_name}-rtb-public"
   Type = "route-table"
   author = var.author
 }
  
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.ecs_vpc.id
   # Local
  route {
    cidr_block = var.vpc_cidr
    gateway_id = "local"
  }

    # Nat
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
  tags = {
    Name   = "${var.network_root_name}-rtb-private"
    Type   = "Route table"
    author = var.author
  }
}

### Attach subnet to route-table

resource "aws_route_table_association" "public_subnet_association-1" {
  route_table_id = aws_route_table.public_route_table.id
  subnet_id = aws_subnet.public_subnet_1.id
}

resource "aws_route_table_association" "public_subnet_association-2" {
  route_table_id = aws_route_table.public_route_table.id
  subnet_id = aws_subnet.public_subnet_2.id
}

resource "aws_route_table_association" "private_subnet_associate-1" {
  route_table_id = aws_route_table.private_route_table.id
  subnet_id = aws_subnet.private_subnet_1.id
}

resource "aws_route_table_association" "private_subnet_associate-2" {
  route_table_id = aws_route_table.private_route_table.id
  subnet_id = aws_subnet.private_subnet_2.id
}

resource "aws_route_table_association" "private_subnet_db_associate-1" {
  route_table_id = aws_route_table.private_route_table.id
  subnet_id = aws_subnet.db_subnet_1.id
}

resource "aws_route_table_association" "private_subnet_db_associate-2" {
  route_table_id = aws_route_table.private_route_table.id
  subnet_id = aws_subnet.db_subnet_2.id
}