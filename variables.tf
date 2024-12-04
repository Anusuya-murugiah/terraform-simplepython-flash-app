variable "vpc_name" {
  type = string
  description = "dev project1 in eu-west-1"
}

variable "cidr_block" {
   type = string
   description = "dev project1 in eu-west-1"
}

variable "cidr_public_subnet"  {
  type = list(string)
  description = "cidr public subnet for dev pro1"
}

variable "cidr_private_subnet" {
  type = list(string)
  description = "cidr private subnet for dev pro1"
}

variable "eu_availability_zone"  {
  type = list(string)
  description = "avaiability zone of dev pro1"
}

variable ami_id {}
variable instance_type {}
variable tag_name {}
variable subnet_id {}
variable vpc_security_group_ids {}
variable associate_public_key_id {}
variable user_data {}
variable public_key {}

variable "ami_id" {
  type = string
  description = "amazon machine image"
}

variable "public_key" {
  type = "string"
  description = "local host public key"
}





