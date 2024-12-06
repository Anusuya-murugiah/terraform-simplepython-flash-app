variable lb_name {}
variable load_balancer_type {}
variable lb_sg_ssh_http_id {}
variable lb_subnet_ids {}
variable lb_target_group_arn {}
variable lb_target_id {}
variable lb_target_group_attachment_port {}
variable lb_listener_protocol {}
variable lb_listener_port {}
variable listener_tg_arn {}

resource "aws_lb" "dev_pro1_lb" {
  name = var.lb_name
  internal = false
  load_balancer_type = var.load_balancer_type
  security_groups = [var.lb_sg_ssh_http_id]
  subnets = var.lb_subnet_ids

  tags = {
    Name = "dev-pro1-lb"
  }
}

resource "aws_lb_target_group_attachment" "dev_pro1_lb" {
  target_group_arn = var.lb_target_group_arn
  target_id = var.lb_target_id
  port = var.lb_target_group_attachment_port
} 

resource "aws_lb_listener" "dev_pro1_lb_listener" {
  load_balancer_arn = aws_lb.dev_pro1_lb.arn
  protocol = var.lb_listener_protocol
  port = var.lb_listener_port

  default_action {
    type = "forward"
    target_group_arn = var.listener_tg_arn
  }
}  
    

