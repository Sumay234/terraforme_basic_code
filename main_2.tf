provider "aws" {
    region = "us-east-1"
}

module "ec2_instances" {
  source = "./modules/ec2_instances"
  ami_value= var.ami_value
  instance_type= var.instance_type_value
  key_name= var.key_name_value
  tags = {
    Name = "fourth-terraform-module"
  }
}