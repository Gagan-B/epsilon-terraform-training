# Configure teh AWS provider
provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "gagan_log_bucket" {
  bucket = "gagan-tf-log-bucket"
  acl    = "log-delivery-write"
}

resource "aws_s3_bucket" "gagan_s3_bucket" {
  bucket = "gagan-bucket-06082021"
  acl    = "private"
  versioning {
    enabled = true
  }
  tags = {
    Name = "Gagan-Bucket"
    BU   = "Gagan-Finance"
  }
  logging {
    target_bucket = aws_s3_bucket.gagan_log_bucket.id
    target_prefix = "log/"
  }
}