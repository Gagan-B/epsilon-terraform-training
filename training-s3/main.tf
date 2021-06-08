# Configure teh AWS provider
provider "aws" {
    region = "us-east-1"
}

resource "aws_s3_bucket" "gagan_s3_bucket" {
    bucket = "gagan-bucket-06082021"
    acl    = "private"
    tags   = {
        Name = "Gagan-Bucket"
        BU   = "Gagan-Finance"
    }
}