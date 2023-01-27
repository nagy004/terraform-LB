resource "aws_instance" "ec2" {
  ami           = var.image-type
  instance_type = var.ec2-type
  associate_public_ip_address = true
  subnet_id = var.subnet-id
  vpc_security_group_ids = [var.SG-id]
  key_name = "nagy"



provisioner "remote-exec" {
  connection {
    type        = "ssh"
    user        = "ubuntu"
    host        = self.public_ip
    private_key = file("./nagy.pem")
    timeout = "4m"
  }

    inline = var.provisioner-proxy
  
}



 tags = {
    Name = var.ec2-name
  }
}