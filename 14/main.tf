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
  key_name   = "deployer-key"
  subnet_id = aws_subnet.subnet.id
  tags = {
    Name = "vpc-instance"
    }
    user_data = << EOF
#! /bin/bash
sudo apt-get update
sudo apt-get install -y docker
sudo docker run -d -p 80:80 nginx
EOF
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDh/Y8p2qQJmCKcoZeAV6ZUHMvfsklapypW+NhrtmR4rTC2wGpP+DhDCdNdcC7yA7vGsILLBA139iurZm7BFlk5wQ+ZDiW+9xmHDjzG+6xg8BHp7ntPKhm6pXjyL0ltNFg1Sx/LpeXeqJXC+dOVo7De4GYuvTl0+53TGrWqyQjS0Rg6ZShPd6hL8txqONPdRbTbwQYw1M74tuQrIyyPbcmmmxKgxDezglB2piXyU+Lv56kzyKfAnSBj4rl44Kbn+QtVXwCiwqoUr9urDA4yiMBm3trpzSOFTS/DJ4aUutEe4JD5FTgfBww2Ou0bx9cVCztTg5c+39lJ2ibVblvjPFZdVcI5UBP+uVuGhsrCSAO7E2A6R/bJF7yEOPQwgU9iYK739FzZuNX7Y4iLWu4nGrYTTTgyqm63mMeflHgYIiCYJFUUcIL9KxdvLHaj7XiRqetFNucCUF8buFOX/ES49aT9z1QLVijU3ltLUy8qUqYfnnzYsIahAdrTPsxsn2RRPhMGx7kveO3XlF7tZcvfNpltbHt9aafMJbbz580Jk1E/ikDT8EhJfoygyCYwUhowfuocDCuBCJHiN9KCgbvb6kTe5kkXAsjnxaqzplvR2uvoD+p/kLhWVjX1RRLYKQfShOUrXg+i9wTO+NP0Z+CDJU8UlVAD/yNNB3o8PF63HhQJzQ== gonzalojvelizpg@gmail.com"
}

