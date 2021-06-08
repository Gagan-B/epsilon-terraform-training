# Configure teh AWS provider
provider "aws" {
  region = var.region
}

resource "aws_instance" "gagan_ec2" {
  ami           = var.ec2_ami
  instance_type = var.ec2_instance_type
  subnet_id     = var.public_subnet_id
}

resource "aws_ebs_volume" "gagan_ebs_volume" {
  availability_zone = "us-east-1a"
  size              = 1
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.gagan_ebs_volume.id
  instance_id = aws_instance.gagan_ec2.id
}
