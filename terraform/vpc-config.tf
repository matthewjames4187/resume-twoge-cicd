# Create the VPC
resource "aws_vpc" "twoge-tf-vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "twoge-tf-vpc"
  }
}

# Create an internet gateway and attach it to the VPC
resource "aws_internet_gateway" "twoge-tf-igw" {
  vpc_id = aws_vpc.twoge-tf-vpc.id
  tags = {
    Name = "twoge-tf-igw"
  }
}

# Create the public subnet
resource "aws_subnet" "twoge-tf-public-subnet" {
  vpc_id     = aws_vpc.twoge-tf-vpc.id
  cidr_block = "10.0.0.0/17"
  availability_zone = "us-east-2a"
  map_public_ip_on_launch = true
  tags = {
    Name = "twoge-tf-public-subnet"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.twoge-tf-vpc.id
  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.twoge-tf-igw.id
}

resource "aws_route_table_association" "public-rt" {
  subnet_id = aws_subnet.twoge-tf-public-subnet.id
  route_table_id = aws_route_table.public.id
}

# Create the private subnet
resource "aws_subnet" "twoge-tf-private-subnet" {
  vpc_id     = aws_vpc.twoge-tf-vpc.id
  cidr_block = "10.0.128.0/17"
  availability_zone = "us-east-2b" 
  tags = {
    Name = "twoge-tf-private-subnet"
  }
}

/*
# Create a NAT Gateway for the private subnet
resource "aws_nat_gateway" "twoge-tf-nat-gateway" {
  allocation_id = aws_eip.twoge-tf-eip.id
  subnet_id = aws_subnet.twoge-tf-private-subnet.id
}

# Create an Elastic IP for the NAT Gateway
resource "aws_eip" "twoge-tf-eip" {}
*/

