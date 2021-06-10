terraform {
  backend "s3" {
    bucket = "gagan-terraform-training"
    key    = "terraform_module.tfstate"
    region = "us-east-1"
  }
}

module "ec2" {
  source     = "./modules/ec2"
  #source     = "git::git@github.com:manishsethi/xebia-epsilon-terraform-training.git//modules/ec2?ref=v0.1.1"
  aws_region = "us-east-1"

}