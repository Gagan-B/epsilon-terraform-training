terraform {
  backend "s3" {
    bucket = "gagan-terraform-training"
    key    = "terraform-lb.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = var.aws_region
}

################################################################################
### Primary VPC
data "aws_vpc" "primary" {
  id = var.vpc_primary_id
}

# uauth target group
resource "aws_lb_target_group" "uauth" {
  name     = "${var.prefix}-targetgroup"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.primary.id
}

resource "aws_lb_target_group_attachment" "uauth" {
  target_group_arn = aws_lb_target_group.uauth.arn
  target_id        = var.aws_instance
  port             = 80
}

# uauth Application LB

resource "aws_lb" "uauth" {
  name                       = "${var.prefix}-uauth"
  load_balancer_type         = "application"
  subnets                    = [var.subnet_primary_public_a_id, var.subnet_primary_public_b_id, var.subnet_primary_public_c_id]
  security_groups            = var.alb_sg
  enable_deletion_protection = true
}


resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.uauth.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.uauth.arn
  }
}