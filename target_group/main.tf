
resource "aws_lb_target_group" "tg" {
  name = var.tg_name
  target_type = var.target_type
  tg_protocol = var.tg_protocol
  tg_port = var.tg_port
  tg_vpc_id = var.tg_vpc_id
  tg_instance_id = var.tg_instance_id
}  
  
  
  
