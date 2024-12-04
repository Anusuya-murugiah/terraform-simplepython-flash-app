


resource "aws_ec2_instance" "local-host" {
  ami = "
  instance_type = var.instance_type
  availability_zone = var.availability_zone
  public_key = 
  
  
