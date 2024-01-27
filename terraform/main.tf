# Create an EC2 instance in the public subnet
resource "aws_instance" "twoge-server" {
  ami           = data.aws_ami.latest_ubuntu.id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.twoge-tf-public-subnet.id
  security_groups = [ "${aws_security_group.twoge-tf-public-sg.id}" ]
  key_name = var.pem_key

  tags = {
    Name = "twoge_server"
    Stage = "dev"
  }
}

resource "aws_db_instance" "twoge-db" {
  allocated_storage    = 20
  storage_type         = var.rds_storage_type
  engine               = var.rds_engine
  engine_version       = var.rds_engine_version
  instance_class       = var.rds_instance_class
  username             = var.rds_username
  password             = var.rds_password
  parameter_group_name = var.rds_parameter_group_name
  skip_final_snapshot  = true #false for resiliency
  vpc_security_group_ids = ["${aws_security_group.twoge-tf-private-sg.id}"]
  db_subnet_group_name   = aws_subnet.twoge-tf-private-subnet.name


  multi_az               = false #true for resiliency
  publicly_accessible    = false
  backup_retention_period = 7
}

output "server_public_ip" {
  value = aws_instance.twoge-server.public_ip
}

output "rds_endpoint" {
  value = aws_db_instance.twoge-db.endpoint
}

output "rds_username" {
  value = aws_db_instance.twoge-db.username
}

output "rds_password" {
  value = aws_db_instance.twoge-db.password
}

output "rds_port" {
  value = aws_db_instance.twoge-db.port
}

output "rds_db_name" {
  value = aws_db_instance.twoge-db.db_name
}
