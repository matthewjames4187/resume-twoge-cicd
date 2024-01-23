# Create a security group for the public subnet
resource "aws_security_group" "twoge-tf-public-sg" {
  name = "twoge-tf-public-sg"
  description = "Security group for the public subnet"
  vpc_id = aws_vpc.twoge-tf-vpc.id

  # Allow inbound traffic on port 80 (HTTP) and port 22 (SSH)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create a security group for the private subnet
resource "aws_security_group" "twoge-tf-private-sg" {
  name = "twoge-tf-private-sg"
  description = "Security group for the private subnet"
  vpc_id = aws_vpc.twoge-tf-vpc.id

    #All inbound traffic on 3306 from public server
    ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [aws_security_group.twoge-tf-public-sg.id] 
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}