module "networking" {
   source = "./networking"
   cidr_block = var.cidr_block
   vpc_name = var.vpc_name
   cidr_public_subnet = var.cidr_public_subnet
   cidr_private_subnet = var.cidr_private_subnet 
   eu_availability_zone = var.eu_availability_zone
}

module "security_groups" {
  source = "./security_groups"
  vpc_id = module.networking.dev_pro1_vpc_id
  sg = "SG for EC2 to enable SSH(22), HTTPS(443) and HTTP(80)"
  sg_jenkins = "Allow port 8080 for jenkins"
}

module "jenkins" {
  source = "./jenkins"
  ami_id = var.ami_id
  instance_type = "t2.micro"
  tag_name = "Jenkins:Ubuntu Linux EC2"
  subnet_id = "
  
}
  
   
