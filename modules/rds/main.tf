resource "aws_db_subnet_group" "subnet_db_group" {
  name = "${lower(var.network_root_name)}-subnet-db-group"
  subnet_ids = [
    var.subnet_db_1_id,
    var.subnet_db_2_id
  ]
  tags = {
    Name = "${var.network_root_name}-subnet-db-group"
    Type = "RDS subnet"
    author = var.author
  }
}

### Setup Multi AZ DB Instance

resource "aws_db_instance" "rds_instance" {
  identifier = "${lower(var.network_root_name)}-rds-instance"
  engine = "mysql"
  engine_version = "8.0.39"
  instance_class = "db.m5.large"
  allocated_storage = 20
  multi_az = true
  storage_type = "gp3"
    db_name = var.db_name
  username = var.db_username
  password = var.db_password
  port = 3306
  publicly_accessible = false
  skip_final_snapshot = true
  db_subnet_group_name = aws_db_subnet_group.subnet_db_group.name
  vpc_security_group_ids = var.security_group_ids

  tags = {
    Name = "${var.network_root_name}-rds-instance"
    Type = "RDS-Instance"
    DatabaseEngine = "MySQL"
    Author = var.author
  }
}

