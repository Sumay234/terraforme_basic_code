provider "aws" {
    region = "us-east-1"

}
resource "aws_instance" "demo" {
    ami = "ami-080e1f13689e07408"
    instance_type = "t2.micro"
    key_name = "for-terraform-virginia"
    tags = {
      Name ="second-time-from-terraform"
    }
}