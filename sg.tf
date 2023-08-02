resource "aws_security_group" "allows_mysql" {
  name        = "roboshop allows_mysql_internal only"
  description = "allows_mysql_internal only"
  vpc_id      = data.terraform_remote_state.vpc.outputs.VPC_ID

  ingress {
    description = "mysql from VPC"
    from_port   = var.MYSQL_PORT_NUMBER
    to_port     = var.MYSQL_PORT_NUMBER
    protocol    = "tcp"
    cidr_blocks = [data.terraform_remote_state.vpc.outputs.VPC_CIDR]
  }

  ingress {
    description = "mysql from Default VPC"
    from_port   = var.MYSQL_PORT_NUMBER
    to_port     = var.MYSQL_PORT_NUMBER
    protocol    = "tcp"
    cidr_blocks = [data.terraform_remote_state.vpc.outputs.DEFAULT_VPC_CIDR]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "roboshop-${var.ENV}-mysql-sg"
  }
}