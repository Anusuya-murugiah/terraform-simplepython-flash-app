#setup the 
resource "aws_vpc" "dev-pro1-eu-west" {
  cidr_block = var.vpc_name

  tags = {
    Name = var.vpc_name
  }
}


