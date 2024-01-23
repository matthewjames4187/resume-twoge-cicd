variable "twoge-tf-default-ubuntu-ami" {
  description = "Default ami for us-east-2 ubuntu"
  type        = string
  default     = "ami-09cfbc2c4bebe0a00"
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
  default = "mysql"
}

variable "rds_engine_version" {
  default = "5.7"
}

variable "rds_instance_class" {
  default = "db.t2.micro"
}

variable "rds_parameter_group_name" {
  default = "default.mysql5.7"
}
