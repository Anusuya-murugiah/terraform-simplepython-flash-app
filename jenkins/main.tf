variable ami_id {}
variable instance_type {}
variable tag_name {}
variable subnet_id {}
variable vpc_security_group_ids {}
variable associate_public_key_id {}
variable user_data {}
variable public_key {}

output "local_host_id" {
  value = aws_instance.local_host.id
}

output "local_host_public_ip" {
  value = aws_instance.local_host.public_ip
}


resource "aws_instance" "local_host" {
  ami = var.ami_id
  instance_type = var.instance_type
  tags = {
    name = var.tag_name
  }
  key_name = "aws_ec2_instance"
  subnet_id = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids
  associate_public_key_id = var.associate_public_key_id

  user_data = var.user_data

  metadata_option {
    http_endpoint = "enabled"
    http_tokens = "required"
  }
}

resource "aws_key_pair" "local_host_public_key" {
  key_name = "aws_ec2_instance"
  public_key = var.public_key
}


  

  
  
