terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.31.0"
    }
    linode = {
      source = "linode/linode"
      version = "1.29.2"
    }
  }
}


provider "aws" {
    region = "us-east-1"
}

resource "aws_vpc" "development-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name: "development"
  }
}

variable "subnet-cidr" {
  description = "Cidr subnet"
}

resource "aws_subnet" "dev-subnet-1" {
  vpc_id = aws_vpc.development-vpc.id
  cidr_block = var.subnet-cidr
  availability_zone = "us-east-1a"
  tags = {
    Name: "subnet-1-dev"
  }
}

data "aws_vpc" "existing_vpc" {
  default = true
}

variable avail_zone {}

resource "aws_subnet" "dev-subnet-2" {
  vpc_id = data.aws_vpc.existing_vpc.id
  cidr_block = "172.31.96.0/20"
  availability_zone = var.avail_zone
  tags = {
    Name: "subnet-2-dev"
  }
}

output "dev-vpc-id" {
  value = aws_vpc.development-vpc.id
}

output "dev-subnet-id" {
  value = aws_subnet.dev-subnet-1.id
}
