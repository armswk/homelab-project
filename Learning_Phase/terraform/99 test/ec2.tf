data "aws_ami" "latest" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"] # Filters for Amazon Linux 2 AMIs
  }
}

output "latest_ami_id" {
  value = data.aws_ami.latest.id
}
