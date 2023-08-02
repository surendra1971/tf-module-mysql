# This is going to inject the schema to DocDB

resource "null_resource" "mysql_schema" {
       
  depends_on = [aws_db_instance.mysql]

  provisioner "local-exec" {
         command = <<EOF
            cd /tmp 
            curl -s -L -o /tmp/mysql.zip "https://github.com/stans-robot-project/mysql/archive/main.zip"
            unzip -o /tmp/mysql.zip 
            cd mysql-main
            mysql -h ${aws_db_instance.mysql.address} -uadmin1 -pRoboShop1 < shipping.sql
        EOF 
    }
}