terraform {
  backend "s3" {
    bucket = "sumay-s3-from-terraform"
    region = "us-east-1"
    key    = "sumay/terraform.tfstate"
  }
}