terraform {
  backend "s3" {
    bucket = "gagan-terraform-training"
    key    = "test1"
    region = "us-east-1"
  }
}
# Configure teh AWS provider
provider "aws" {
  region = var.region
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0.20210427.0-x86_64-gp2"]
  }
  owners = ["137112412989"]
}

resource "aws_instance" "gagan_ec2" {
  ami               = data.aws_ami.amazon_linux.id
  instance_type     = var.ec2_instance_type
  subnet_id         = var.public_subnet_id
  availability_zone = var.availability_zone
  #provisioner "file" {
  #  source ="hello.sh"
  #  destination = "/tmp/hello.sh"
  #}
  #provisioner "remote-exec" {
  #  inline = [
  #    "chmod +x /tmp/hello.sh",
  #    "sh /tmp/hello.sh"
  #  ]
  #}
}

resource "aws_ebs_volume" "gagan_ebs_volume" {
  availability_zone = aws_instance.gagan_ec2.availability_zone
  size              = 50
  tags = {
    Name = "gagan-volume1"
  }
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.gagan_ebs_volume.id
  instance_id = aws_instance.gagan_ec2.id
}

resource "aws_security_group" "ec2_sg" {
  name        = "allow_80_443"
  description = "security group for ec2"

  ingress {
    description = "80 ingress"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  ingress {
    description = "443 ingress"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

}

resource "aws_network_interface_sg_attachment" "sg_attachment" {
  security_group_id    = aws_security_group.ec2_sg.id
  network_interface_id = aws_instance.gagan_ec2.primary_network_interface_id
}