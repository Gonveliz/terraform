terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "web" {
  # ami           = data.aws_ami.ubuntu.id
  ami             = "ami-052efd3df9dad4825"
  instance_type = "t2.micro"
  count     = 3
  tags = {
    Name = "HelloWorld"
  }
}