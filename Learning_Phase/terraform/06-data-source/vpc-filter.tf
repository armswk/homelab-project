data "aws_vpc" "terraform_vpc" {
  #provider = aws.eu_central
  tags = {
    Env = "terraform"
  }
}

output "terraform_vpc_id" {
  value = data.aws_vpc.terraform_vpc.id
}