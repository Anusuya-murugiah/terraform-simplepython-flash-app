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
  subnet_id = module.networking.dev_proj1_public_subnet[0]
  vpc_security_group_ids = [module.security_groups.sg_ssh_http_id, module.security_groups.sg_jenkins]
  associate_public_ip_address = true
  public_key = var.public_key
  user_data = templatefile("./jenkins_runner_script/jenkins_installer.sh", {})
}

module  "target_group" {
  source = "./target_group"
  tg_name = "dev-pro1-alb"
  tg_vpc_id = module.networking.dev_pro1_vpc_id
  tg_protocol = "HTTP"
  tg_port = 8080
  target_id = module.jenkins.local_host_id
}

module "load_balancer" {
  source = "./load_balancer"
  lb_name = "dev-pro1-lb"
  load_balancer_type = "application"
  lb_sg_ssh_http_id  = module.security_groups.sg_ssh_http_id
  lb_subnet_ids = tolist(module.networking.dev_proj1_public_subnet)
  lb_target_group_arn = module.target_group.tg_arn
  lb_target_id = module.jenkins.local_host_id
  lb_target_group_attachment_port = 8080
  lb_listener_protocol = "HTTP"
  lb_listener_port = 80
  listener_tg_arn = module.target_group.tg_arn
} 
   
