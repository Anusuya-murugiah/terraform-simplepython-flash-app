varaiable "vpc_name" {
  type = string
  description = "dev project1 in eu-west-1"
}

variable "cidr_block" {
   type = string
   description = "dev project1 in eu-west-1"
}

variable "public_cidr_block"  {
  type = list(string)
  description = "public cidr block for dev pro1"
}

variable "eu_availability_zone"  {
  type = list(string)
  description = "avaiability zone of dev pro1"
}
