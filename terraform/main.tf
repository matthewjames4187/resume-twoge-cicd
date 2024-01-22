# Create an EC2 instance in the public subnet
resource "aws_instance" "twoge-tf-wp" {
  ami           = var.twoge-tf-default-ubuntu-ami
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.twoge-tf-public-subnet.id
  security_groups = [ "${aws_security_group.twoge-tf-public-sg.id}" ]
  key_name = "cpdevopsew-us-east-2"
  private_ip = "10.0.0.4"

  tags = {
    Name = "ansible_dynamic_1"
    Stage = "dev"
    Team = "payments"
  }
}

# Create an EC2 instance in the public subnet
resource "aws_instance" "twoge-tf-mysql-db" {
  ami           = var.twoge-tf-default-ubuntu-ami
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.twoge-tf-public-subnet.id
  security_groups = [ "${aws_security_group.twoge-tf-public-sg.id}" ]
  key_name = "cpdevopsew-us-east-2"
  private_ip = "10.0.0.7"

  tags = {
    Name = "ansible_dynamic_2"
    Stage = "prod"
    Team = "payments"
  }
}