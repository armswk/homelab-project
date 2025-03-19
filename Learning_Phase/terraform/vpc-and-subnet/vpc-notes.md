ref: https://github.com/lm-academy/terraform-course/blob/main/exercises/exercise02-terraform.md

## Introduction: Creating VPCs and Subnets with Terraform and IaC

1. A VPC with a CIDR block of `10.0.0.0/16`.
2. One public subnet with a CIDR block of `10.0.0.0/24`.
3. One private subnet with a CIDR block of `10.0.1.0/24`.
4. One Internet Gateway.
5. One public route table with a route to the Internet Gateway, and the correct association between the public subnet and the public route table.

### Useful Resources

-   AWS Terraform Provider: [https://registry.terraform.io/providers/hashicorp/aws](https://registry.terraform.io/providers/hashicorp/aws)

## Step-by-Step Guide

1. Begin by initializing your Terraform configuration with the `terraform` block. This block sets up the necessary details regarding the providers that will be used in your configuration. In this case, the AWS provider is required.

    ```
    terraform {
      required_providers {
        aws = {
          source  = "hashicorp/aws"
          version = "~> 5.0"
        }
      }
    }
    ```

2. Next, set up your AWS provider with the `provider` block. Here, you need to specify the region in which your resources will be created.

    ```
    provider "aws" {
      region = "eu-west-1"
    }
    ```

3. Create a VPC using the `aws_vpc` resource. You need to specify a CIDR block for your VPC, as well as the `Name` tag with the value `Terraform VPC`.

    ```
    resource "aws_vpc" "demo_vpc" {
      cidr_block = "10.0.0.0/16"

      tags = {
        Name = "Terraform VPC"
      }
    }
    ```

4. Then, create two subnets within this VPC using the `aws_subnet` resource. Make sure to reference your VPC ID and set an appropriate CIDR block for each subnet.

    ```
    resource "aws_subnet" "public_subnet" {
      vpc_id     = aws_vpc.demo_vpc.id
      cidr_block = "10.0.0.0/24"
    }

    resource "aws_subnet" "private_subnet" {
      vpc_id     = aws_vpc.demo_vpc.id
      cidr_block = "10.0.1.0/24"
    }
    ```

5. Next, create an Internet gateway and attach it to your VPC with the `aws_internet_gateway` resource.

    ```
    resource "aws_internet_gateway" "igw" {
      vpc_id = aws_vpc.demo_vpc.id
    }
    ```

6. Create a route table for your public subnet using the `aws_route_table` resource. This table will direct all traffic (`0.0.0.0/0`) to the Internet gateway.

    ```
    resource "aws_route_table" "public_rtb" {
      vpc_id = aws_vpc.demo_vpc.id

      route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
      }
    }
    ```

7. Finally, associate the route table with your public subnet using the `aws_route_table_association` resource.

    ```
    resource "aws_route_table_association" "public_subnet" {
      subnet_id      = aws_subnet.public_subnet.id
      route_table_id = aws_route_table.public_rtb.id
    }
    ```