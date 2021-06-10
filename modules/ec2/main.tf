provider "aws" {
  region = var.aws_region
}

data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0.20210427.0-x86_64*"]
  }

  owners = ["137112412989"]
}

resource "aws_ebs_volume" "add_volume" {
  availability_zone = "us-east-1d"
  size              = 50
  tags = {
    Name = "${var.ec2_name}-volume1"
  }
}

resource "aws_volume_attachment" "ebs_ec2_attachment" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.add_volume.id
  instance_id = aws_instance.xebia.id
}

resource "aws_instance" "xebia" {
  ami               = data.aws_ami.amazon_linux.id
  instance_type     = var.ec2_instancetype
  subnet_id         = var.subnet_id
  key_name          = var.key_name
  availability_zone = var.ec2_az
  tags = {
    Name = var.ec2_name
  }
} 