terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.20"
    }
  }
  backend "s3" {
    bucket = "tfstategonzalo"
    key    = "terraform/ec2/12.tfstate"
    region = "us-east-1"
  }
}
provider "aws" {
  region = "us-east-1"
}
#vpc
resource "aws_vpc" "red" {
  cidr_block = "10.0.0.0/16"
}
#sub-net
resource "aws_subnet" "subnet" {
  vpc_id     = aws_vpc.red.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Subnet"
  }
}
resource "aws_instance" "web" {
  ami             = "ami-052efd3df9dad4825"
  instance_type = "t2.micro"
  user_data = "${file("userdata.yaml")}"
  subnet_id = aws_subnet.subnet.id
  tags = {
    Name = "vpc-instance"
    }
}