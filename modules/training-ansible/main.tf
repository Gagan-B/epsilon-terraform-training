terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

  backend "s3" {
    bucket = "gagan-terraform-training"
    key    = "terraform-ansible.tfstate"
    region = "us-east-1"
  }

}

provider "aws" {
  region = var.aws_region
}


data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "web" {
  count         = 1
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name      = "gagan"

  provisioner "remote-exec" {
    inline = ["sudo apt update", "sudo apt install python3 -y", "sudo apt install apache2 -y", "echo Done!"]

    connection {
      host        = self.public_ip
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(var.pvt_key)
    }
  }
}
