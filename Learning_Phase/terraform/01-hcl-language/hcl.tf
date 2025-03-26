# Always required for terraform to know which module/source/provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.37.0"
    }
  }
}

# Basic Structure
# <provider_block> "resource-types" "labels" {
#     .....
# }

# Variable Setup
variable "bucket_name" {
  type        = string
  description = "My variable used to set bucket name"
  default     = "my_default_bucket_name"
}

# Actively managed by us, by our Terraform project
resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name
}

# Managed somewhere else, we just want to use in our project
data "aws_s3_bucket" "my_external_bucket" {
  bucket = "not-managed-by-us"
}

# Print the output
output "bucket_id" {
  value = aws_s3_bucket.my_bucket.id
}

#This variable is only available within this Terraform project.
locals {
  local_example = "This is a local variable"
}

#import module from the folder
module "my_module" {
  source = "./module-example"
}