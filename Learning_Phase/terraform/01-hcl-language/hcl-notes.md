Ref: [https://github.com/lm-academy/terraform-course/blob/main/exercises/exercise04-hcl.md](https://github.com/lm-academy/terraform-course/blob/main/exercises/exercise04-hcl.md)
# Overview of the Hashicorp Configuration Language (HCL)

## Syntax

1. A declaration of required providers, specifically the AWS provider from HashiCorp.
2. A `resource` block defining an AWS S3 bucket.
3. A `data` block for an externally managed AWS S3 bucket.
4. A variable named `bucket_name`, which is used in the created `resource` block to define the bucket's name.
5. An `output` block that outputs the ID of the managed AWS S3 bucket.
6. A `locals` block defining a local variable named `local_example`.
7. A module block that includes a module located in the `./module-example` directory.

### Useful Resources

-   [https://developer.hashicorp.com/terraform/language/syntax](https://developer.hashicorp.com/terraform/language/syntax)

## Step-by-Step Guide

1. Start by declaring your required providers. In this case, we are using the AWS provider, version `5.37.0`, sourced from HashiCorp. This block tells Terraform where to fetch the provider.

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

2. Next, define a resource block for an AWS S3 bucket that you want to manage with this Terraform script. The `bucket` argument is set to a variable which we will define later.

    ```
    resource "aws_s3_bucket" "my_bucket" {
      bucket = var.bucket_name
    }
    ```

3. Define a data block for an AWS S3 bucket that is managed outside of this Terraform script. This allows us to fetch and use data about this external bucket.

    ```
    data "aws_s3_bucket" "my_external_bucket" {
      bucket = "not-managed-by-us"
    }
    ```

4. Define a `bucket_name` variable. This is used in the `resource` block to set the `bucket` argument.

    ```
    variable "bucket_name" {
      type        = string
      description = "My variable used to set bucket name"
      default     = "my_default_bucket_name"
    }
    ```

5. Define an output block to output the ID of the bucket that we are managing with this Terraform script.

    ```
    output "bucket_id" {
      value = aws_s3_bucket.my_bucket.id
    }
    ```

6. Define a local block to create a local variable. This variable is only available within this Terraform project.

    ```
    locals {
      local_example = "This is a local variable"
    }
    ```

7. Lastly, use a module block to include a module that is located in the `./module-example` directory.

    ```
    module "my_module" {
      source = "./module-example"
    }
    ```