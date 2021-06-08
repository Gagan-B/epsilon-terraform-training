# Configure teh AWS provider
provider "aws" {
  region = var.region
}

resource "aws_instance" "gagan_ec2" {
  ami           = var.ec2_ami
  instance_type = var.ec2_instance_type
  subnet_id     = var.public_subnet_id
}
