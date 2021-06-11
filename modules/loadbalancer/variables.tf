variable "prefix" {
  default = "gagan"
}

variable "alb_sg" {
  default = ["sg-90134791"]
}

variable "aws_instance" {
  default = "i-01ba7f22d7dbd3ef1"
}

variable "aws_region" {
  default = "us-east-1"
}

variable "vpc_primary_id" {
  default = "vpc-7a22a707"
}

variable "subnet_primary_public_a_id" {
  default = "subnet-540e6632"
}

variable "subnet_primary_public_b_id" {
  default = "subnet-1684f337"
}

variable "subnet_primary_public_c_id" {
  default = "subnet-1f67db2e"
}