variable tg_name {}
variable tg_protocol {}
variable tg_port {}
variable tg_variable {}
variable tg_instance_id {}

output "tg_arn" {
  value = aws_lb_target_group.tg.arn
}


resource "aws_lb_target_group" "tg" {
  name = var.tg_name
  target_type = var.target_type
  tg_protocol = var.tg_protocol
  tg_port = var.tg_port
  tg_vpc_id = var.tg_vpc_id
  
}  

resource "aws_lb_target_group_attachment" "lga" {
  target_group_arn = tg_arn
  tg_instance = 
}
  
  
  
