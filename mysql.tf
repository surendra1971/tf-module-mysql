# Provisions RDS : MySQL

resource "aws_db_instance" "mysql" {
  allocated_storage    = var.MYSQL_STORAGE
  engine               = "mysql"
  engine_version       = var.MYSQL_ENGINE_VERSION
  instance_class       = var.MYSQL_INSTANCE_TYPE
  username             = local.MYSQL_USER
  password             = local.MYSQL_PASS
  parameter_group_name = aws_db_parameter_group.mysql_pg.name
  skip_final_snapshot  = true
  db_subnet_group_name    = aws_db_subnet_group.mysql_subnet_group.name
  vpc_security_group_ids  = [aws_security_group.allows_mysql.id]
}

# creates subnet group 
resource "aws_db_subnet_group" "mysql_subnet_group" {
  name       = "roboshop-mysql-${var.ENV}-subnetgroup"
  subnet_ids = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS

  tags = {
    Name = "roboshop-mysql-${var.ENV}-subnetgroup"
  }
}

resource "aws_db_parameter_group" "mysql_pg" {
  name   = "roboshop-${var.ENV}-mysql-pg"
  family = "mysql5.7"
}
