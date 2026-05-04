# RDS Subnet Group
resource "aws_db_subnet_group" "main" {
  name       = "${var.project_name}-db-subnet-group"
  subnet_ids = [var.private_subnet_id, var.public_subnet_id]

  tags = {
    Name = "${var.project_name}-db-subnet-group"
  }
}

# RDS Instance
resource "aws_db_instance" "mysql" {
  identifier        = "${var.project_name}-db"
  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t3.micro"
  allocated_storage = 20

  db_name  = "ravishop"
  username = var.db_username
  password = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [var.rds_sg_id]

  skip_final_snapshot = true
  publicly_accessible = false

  tags = {
    Name        = "${var.project_name}-db"
    Environment = var.environment
  }
}
