terraform {
  required_version = ">=1.6.0"
  backend "s3" {
    region  = "eu-central-1"
    bucket  = "siwa-terraform-state"
    key     = "terraform-state"
    encrypt = true
    profile = "terraform-dev"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.10"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region  = "eu-central-1"
  profile = "terraform-dev"
}
