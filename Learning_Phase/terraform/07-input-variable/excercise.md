## Desired Outcome

If you wish to give it a shot before looking into the detailed step-by-step and the solution videos, here is an overview of what the created solution should deploy:

1. Create a `variables.tf` file with a single variable named `aws_region`.
2. Create a `provider.tf` file with the standard configuration code we have been using so far (Terraform required version and the AWS provider requirements).
3. Use the `aws_region` variable to set the region for configuring the `aws` provider.
4. Create an EC2 instance using the `aws_ami` data source for the Ubuntu AWS AMI.