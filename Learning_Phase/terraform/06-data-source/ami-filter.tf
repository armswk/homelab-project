## EU-AMI
# data "aws_ami" "ubuntu_eu" {
#   most_recent = true
#   owners      = ["099720109477"] # Owner is Canonical
#   #provider    = aws.eu_central

#   filter {
#     name   = "name"
#     values = ["ubuntu/images/hvm-ssd/ubuntu-*-22.04-amd64-server-*"]
#   }

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }
# }

## US-AMI
# data "aws_ami" "ubuntu_us" {
#   most_recent = true
#   owners      = ["099720109477"] # Owner is Canonical
#   provider    = aws.us_east

#   filter {
#     name   = "name"
#     values = ["ubuntu/images/hvm-ssd/ubuntu-*-22.04-amd64-server-*"]
#   }

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }

  ## If not specified the region in the provider.tf
  #   filter {
  #     name = "region"
  #     values = "us-east-1"
  #   }
#}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"] # Filters for Amazon Linux 2 AMIs
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}


# output "ubuntu_ami_data_eu" {
#   value = data.aws_ami.ubuntu_eu.id
# }

# output "ubuntu_ami_data_us" {
#   value = data.aws_ami.ubuntu_us.id
# }


output "amazon_ami_data" {
  value = data.aws_ami.amazon_linux.id
}