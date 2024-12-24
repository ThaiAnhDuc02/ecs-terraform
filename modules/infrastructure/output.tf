output "vpc_id" {
  value = aws_vpc.ecs_vpc.id
}

output "vpc_arn" {
  value = aws_vpc.ecs_vpc.arn
}

output "subnet_private_1_id" {
  value = aws_subnet.private_subnet_1.id
}
output "subnet_private_2_id" {
  value = aws_subnet.private_subnet_2.id
}
output "subnet_public_1_id" {
  value = aws_subnet.public_subnet_1.id
}
output "subnet_public_2_id" {
  value = aws_subnet.public_subnet_2.id
}
output "subnet_db_1_id" {
  value = aws_subnet.db_subnet_1.id
}
output "subnet_db_2_id" {
  value = aws_subnet.db_subnet_2.id
}

# Subnet arn
output "subnet_private_1_arn" {
  value = aws_subnet.private_subnet_1.arn
}
output "subnet_private_2_arn" {
  value = aws_subnet.private_subnet_2.arn
}
output "subnet_public_1_arn" {
  value = aws_subnet.public_subnet_1.arn
}
output "subnet_public_2_arn" {
  value = aws_subnet.public_subnet_2.arn
}

# Internet Gateway

output "igw_id" {
  value = aws_internet_gateway.igw.id
}
output "igw_arn" {
  value = aws_internet_gateway.igw.arn
}
# Nat Gateway
output "nat_gw_id" {
  value = aws_internet_gateway.igw.id
}
output "nat_gw_arn" {
  value = aws_internet_gateway.igw.arn
}
 