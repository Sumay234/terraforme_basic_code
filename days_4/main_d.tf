provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "sumay" {
  instance_type = "t2.micro"
  ami = "ami-080e1f13689e07408"
  key_name = "for-terraform-virginia"
  tags = {
    Name = "terraform-Day-4"
  }
}

resource "aws_s3_bucket" "s3_bucket" {
  bucket = "sumay-s3-from-terraform"
}