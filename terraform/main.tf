# Create an EC2 instance in the public subnet
resource "aws_instance" "twoge-tf-wp" {
  ami           = var.twoge-tf-default-ubuntu-ami
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.twoge-tf-public-subnet.id
  security_groups = [ "${aws_security_group.twoge-tf-public-sg.id}" ]
  key_name = "cpdevopsew-us-east-2"
  private_ip = "10.0.0.4"

  tags = {
    Name = "twoge_frontend_server"
    Stage = "dev"
  }
}

resource "aws_db_instance" "example" {
  allocated_storage    = 20
  storage_type         = var.rds_storage_type
  engine               = var.rds_engine
  engine_version       = var.rds_engine_version
  instance_class       = var.rds_instance_class
  username             = var.rds_username
  password             = var.rds_password
  parameter_group_name = var.rds_parameter_group_name
  skip_final_snapshot  = true
  vpc_security_group_ids = ["${aws_security_group.twoge-tf-private-sg.id}"]
  db_subnet_group_name   = "example-subnet-group"

  multi_az               = false #true for resiliency
  publicly_accessible    = false
  backup_retention_period = 7
}

output "rds_endpoint" {
  value = aws_db_instance.example.endpoint
}
