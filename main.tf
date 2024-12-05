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
  subnet_id = tolist(module.networking.dev_proj1_public_subnet)[0]
  vpc_security_group_ids = [module.security_groups.sg_ssh_http_id, module.security_groups.sg_jenkins]
  associate_public_key_id = true
  user_data = templatefile("./jenkins_runner_script/jenkins_installer.sh", {})
}

module  "target_group" {
  source = "./target-group"
  tg_name = "dev-pro1-alb"
  tg_vpc_id = module.networking.dev_pro1_vpc_id
  tg_protocol = "HTTP"
  tg_port = 8080
  tg_instance = module.jenkins.local_host_id
}

module "load_balancer" {
  source = "./load_balancer"
  
  
} 
   
