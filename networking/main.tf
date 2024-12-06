variable "vpc_name" {}
variable "cidr_block" {}
variable "cidr_public_subnet" {}
variable "cidr_private_subnet" {}
variable "eu_availability_zone" {}

output "dev_pro1_vpc_id" {
  value = aws_vpc.dev_pro1_eu_west.id
}

output "dev_proj1_public_subnet" {
  value = aws_subnet.dev_pro1_public_subnet[*].id
}

#setup the vpc
resource "aws_vpc" "dev_pro1_eu_west" {
  cidr_block = var.cidr_block

  tags = {
    Name = var.vpc_name
  }
}

#setup the public subnet
resource "aws_subnet" "dev_pro1_public_subnet" {
  count = length(var.cidr_public_subnet)
  
  cidr_block = element(var.cidr_public_subnet,count.index)
  vpc_id = aws_vpc.dev_pro1_eu_west.id
  availability_zone = element(var.eu_availability_zone, count.index)

  tags = {
    Name = "dev-pro1-public-subnet-${count.index + 1}"
  }
}

#setup the private subnet
resource "aws_subnet" "dev_pro1_private_subnet" {
  count = length(var.cidr_private_subnet)

  cidr_block = element(var.cidr_private_subnet,count.index)
  availability_zone = element(var.eu_availability_zone, count.index)
  vpc_id = aws_vpc.dev_pro1_eu_west.id

  tags = {
    Name = "dev-pro1-private-subnet-${count.index + 1}"
  }
}

#setup the internet gateway
resource "aws_internet_gateway" "dev_pro1_internet_gateway" {
  vpc_id = aws_vpc.dev_pro1_eu_west.id
  tags = {
    Name = "dev-pro1-internet-gateway"
  }
}

#setup the public route table 
resource "aws_route_table" "dev_pro1_public_route_table" {
  vpc_id = aws_vpc.dev_pro1_eu_west.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id =  aws_internet_gateway.dev_pro1_internet_gateway.id
  }
  tags = {
    Name = "dev-pro1-public-route-table"
  }
}

#setup the private route table
resource "aws_route_table" "dev_pro1_private_route_table"  {
  vpc_id = aws_vpc.dev_pro1_eu_west.id
   tags = {
    Name = "dev-pro1-private-route-table"
  }
}

#setup public route table association
resource "aws_route_table_association" "dev_pro1_public_route_table_asso" {
    count = length(aws_subnet.dev_pro1_public_subnet)
    route_table_id = aws_route_table.dev_pro1_public_route_table.id
    subnet_id = aws_subnet.dev_pro1_public_subnet[count.index].id
}

#setup the public table association
resource "aws_route_table_association" "dev_pro1_private_table_asso" {
  count = length(aws_subnet.dev_pro1_private_subnet)
  subnet_id = aws_subnet.dev_pro1_private_subnet[count.index].id
  route_table_id = aws_route_table.dev_pro1_private_route_table.id
}



