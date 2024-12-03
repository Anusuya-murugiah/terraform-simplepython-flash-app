variable "vpc_id" {}

resource "aws_resource_group" {
  name = var.security_group
  description = "enable port for SSH(22) and HTTP(80)"
  vpc_id = "var.vpc_id"

  ingress {
    cidr_block = ["0.0.0.0/0"]
    description = "enable 22 port for SSH"
    from_port = 22
    ip_protocol = "tcp"
    to_port  = 22
   }

   ingress {
     cidr_block = ["0.0.0.0/0"]
     description = "enable 80 port for HTTP"
     from_port = 80
     ip_protocol = "tcp"
     to_port = 80
   }

   ingress {
     cidr_blocks = ["0.0.0.0/0"]
     description = "enable 443 port for HTTPS"
     from_port = 443
     ip_protocol = "tcp"
     to_port = 443
   }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "open to internet"
    from_port = 0
    ip_protocol = "-1"
    to_port = 0
  }

  tags = {
    Name = "security group for SSH, HTTP and HTTPS"
  }
}

