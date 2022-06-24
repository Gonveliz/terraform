terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  backend "s3" {
    bucket = "tfstategonzalo"
    key    = "terraform/ec2/ejemplo.tfstate"
    region = "us-east-1"
  }
}
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "web" {
  for_each= var.instances
  ami             = "ami-052efd3df9dad4825"
  instance_type = "t2.micro"
  tags = {
    Name = each.key,
    adicional = each.value
  }
}