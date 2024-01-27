data "aws_ami" "latest_ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical's owner ID
}

output "instance_id" {
  value = aws_instance.ubuntu_node.id
}

variable "instance_type" {
  default = "t2.micro"
}

variable "rds_username" {
  type    = string
  default = file("secrets.tfvars")["database_username"]
}

variable "rds_password" {
  type    = string
  default = file("secrets.tfvars")["database_password"]
}

variable "rds_storage_type" {
  default = "gp2"
}

variable "rds_engine" {
  default = "postgres"
}

variable "rds_engine_version" {
  default = "13"
}

variable "rds_instance_class" {
  default = "db.t2.micro"
}

variable "rds_parameter_group_name" {
  default = "default.postgres13"
}

variable "pem_key" {
  type    = string
  default = file("secrets.tfvars")["pem_key"]
}