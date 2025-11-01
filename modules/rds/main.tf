resource "aws_db_subnet_group" "rds_subnet" {
  name       = "${var.project_name}-${var.environment}-rds-subnet"
  subnet_ids = var.subnet_ids
}

resource "aws_db_instance" "rds" {
  identifier              = "${var.project_name}-${var.environment}-db"
  engine                  = var.engine
  instance_class          = var.instance_class
  allocated_storage       = var.allocated_storage
  name                    = var.db_name
  username                = var.username
  password                = var.password
  skip_final_snapshot     = true
  vpc_security_group_ids  = var.vpc_security_group_ids
  db_subnet_group_name    = aws_db_subnet_group.rds_subnet.name
  publicly_accessible     = false
}
