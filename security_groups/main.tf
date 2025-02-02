variable "vpc_id" {}
variable "sg" {}
variable "sg_jenkins" {}

output "sg_ssh_http_id" {
  value = aws_security_group.ec2-ssh-http.id
}

output "sg_jenkins" {
  value = aws_security_group.ec2-jenkins.id
}

resource "aws_security_group" "ec2-ssh-http" {
  name = var.sg
  description = "enable port for SSH(22) and HTTP(80)"
  vpc_id = var.vpc_id

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "enable 22 port for SSH"
    from_port = 22
    protocol = "tcp"
    to_port  = 22
   }

   ingress {
     cidr_blocks = ["0.0.0.0/0"]
     description = "enable 80 port for HTTP"
     from_port = 80
     protocol = "tcp"
     to_port = 80
   }

   ingress {
     cidr_blocks = ["0.0.0.0/0"]
     description = "enable 443 port for HTTPS"
     from_port = 443
     protocol = "tcp"
     to_port = 443
   }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "open to internet"
    from_port = 0
    protocol = "-1"
    to_port = 0
  }

  tags = {
    Name = "security group for SSH, HTTP and HTTPS"
  }
}

resource "aws_security_group" "ec2-jenkins" { 
  vpc_id = var.vpc_id
  description = "allow jenkins port"
  name = var.sg_jenkins

  ingress {
    from_port = 8080
    protocol = "tcp"
    to_port = 8080
    description = "allow jenkins port"
    cidr_blocks = ["0.0.0.0/0"]
  }

 } 




