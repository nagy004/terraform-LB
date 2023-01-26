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
  #[
  #     "sudo apt-get update",
  #     "sudo apt-get install -y nginx",
  #     "echo 'server { \n listen 80 default_server; \n  listen [::]:80 default_server; \n  server_name _; \n  location / { \n  proxy_pass http://${module.ALB.alp-dns-private}; \n  } \n}' > default",
  #     "sudo mv default /etc/nginx/sites-enabled/default",
  #     "sudo systemctl stop nginx",
  #     "sudo systemctl start nginx"
  #     # "sudo systemctl start nginx"
    
  # ]
}



 tags = {
    Name = var.ec2-name
  }
}