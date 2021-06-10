variable "region" {
  description = "Define the region for AWS Resource creation"
  default     = "us-east-1"
}

variable "ec2_ami" {
  description = "Provide the ami id for the ec2 instance creation"
  default     = "ami-0d5eff06f840b45e9"
}

variable "ec2_instance_type" {
  description = "Provide the instance_type for the ec2 instance creation"
  default     = "t2.micro"
}

variable "public_subnet_id" {
  default = "subnet-540e6632"
}

variable "availability_zone" {
  default = "us-east-1d"
}