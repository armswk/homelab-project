data "aws_availability_zones" "available" {
  state    = "available"
  #provider = aws.eu_central
}

output "azs" {
  value = data.aws_availability_zones.available.id
}