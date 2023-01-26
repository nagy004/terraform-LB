resource "aws_instance" "ec2" {
  ami           = var.image-type
  instance_type = var.ec2-type
  # associate_public_ip_address = true
  subnet_id = var.subnet-id
  vpc_security_group_ids = [var.SG-id]
  key_name = "nagy"
  # count = length(var.ec2-name)
  user_data = <<EOF
    #!/bin/bash
    # Use this for your user data (script from top to bottom)
    # install httpd (Linux 2 version)
    yum update -y
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
    echo "<h1>Hello World from ec2 terraform $(hostname -f)</h1>" > /var/www/html/index.html
    EOF


# provisioner "remote-exec" {
#   connection {
#     type        = "ssh"
#     user        = "ubuntu"
#     host        = self.public_ip
#     private_key = file("./nagy.pem")
#     timeout = "4m"
#   }

#   inline = [
#       "sudo apt-get update",
#       "sudo apt-get install -y nginx",
#       # "sudo systemctl start nginx"
    
#   ]
# }



 tags = {
    Name = var.ec2-name
  }
}