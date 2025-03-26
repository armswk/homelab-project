terraform {
    required_providers {
        aws = {
            soruce = "hashicorp/aws"
            version = "~> 5.0"
        }
    }
}

provider "aws" {
    region = "eu-central-1"
  
}
resource "aws_vpc" "demo_siwa_vpc" {
    cidr_block = "10.0.0.0/16"

    tags = {
        Name = "Siwa Terraform VPC"
    }
}

resource "aws_subnet" "siwa_public_subnet" {
  vpc_id = aws_vpc.demo_siwa_vpc.id
  cidr_block = "10.0.0.0/24"
}

resource "aws_subnet" "siwa_private_subnet" {
  vpc_id = aws_vpc.demo_siwa_vpc.id
  cidr_block = "10.0.1.0/24"
}

resource "aws_internet_gateway" "siwa_igw" {
  vpc_id = aws_vpc.demo_siwa_vpc.id
}

resource "aws_route_table" "siwa_public_rtb" {
  vpc_id = aws_vpc.demo_siwa_vpc

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.siwa_igw.id
  }
}

resource "aws_route_table_association" "siwa_public_subnet" {
  subnet_id = aws_subnet.siwa_public_subnet.id
  route_table_id = aws_route_table.siwa_public_rtb.id
}