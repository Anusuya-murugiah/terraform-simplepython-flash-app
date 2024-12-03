resource "aws_resource_group" {
  name = var.security_group
  description = "enable port for SSH(22) and HTTP(80)
  vpc_id = 

}

