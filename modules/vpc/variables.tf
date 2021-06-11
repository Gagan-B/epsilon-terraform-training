variable "aws_region" {
  default = "us-east-1"
}

variable "vpc_cidr" {
    default = "10.0.0.0/16"
}

variable "environment" {
    default = "production"
}

variable "private_subnets_cidr" {
    default = "10.0.0.0/28"
}

variable "public_subnets_cidr" {
    default = "10.0.1.0/28"
}

variable "availability_zones" {
    default = "us-east-1a"
}