Steps for implementation:

[] Deploy a VPC and a subnet
[] Deploy an internet gateway and associate it with the VPC
[] Setup a route table with a route to the IGW and associate it with the subnet
[] Deploy an EC2 instance inside of the created subnet and associate a public IP
[] Associate a security group that allows public ingress
[] Change the EC2 instance to use a publicly available NGINX AMI
[] Destroy everything