module "vpc-iti" {
    source = "./vpc"
    vpc-cidr = ["10.0.0.0/16"]
    vpc-name = "vpc-iti"
  
}

#subnets----------------------------------------------------

module "subnet-pub-1" {
    source = "./pub-subnets"
    subnet-cidr = "10.0.0.0/24"
    subnet-name = "n-pub-subnet1"
    vpc-id = module.vpc-iti.myvpc-id
    availability_zone = "us-east-1a"

    RT-cidr = "0.0.0.0/0"
    internet-GW-id = module.gatways.inter-gateway-id
  
}

module "subnet-pub-2" {
    source = "./pub-subnets"
    subnet-cidr = "10.0.2.0/24"
    subnet-name = "n-pub-subnet2"
    vpc-id = module.vpc-iti.myvpc-id
    availability_zone = "us-east-1b"

    RT-cidr = "0.0.0.0/0"
    internet-GW-id = module.gatways.inter-gateway-id

}

module "subnet-priv-1" {
    source = "./priv-subnets"
    subnet-cidr = "10.0.3.0/24"
    subnet-name = "n-priv-subnet1"
    vpc-id = module.vpc-iti.myvpc-id
    availability_zone = "us-east-1a"

    RT-cidr = "0.0.0.0/0"
    Nat-GW-id = module.gatways.nat-gateway_id
     
  
}

module "subnet-priv-2" {
    source = "./priv-subnets"
    subnet-cidr = "10.0.4.0/24"
    subnet-name = "n-priv-subnet2"
    vpc-id = module.vpc-iti.myvpc-id
    availability_zone = "us-east-1b"

    RT-cidr = "0.0.0.0/0"
    Nat-GW-id = module.gatways.nat-gateway_id
     
  
}


#SG & GateWays----------------------------------------------
module "SG" {
    source = "./Security-G"
    SG-name = "nagy-SG"
    vpc-id = module.vpc-iti.myvpc-id
    cidr = "0.0.0.0/0"
  
}


module "gatways" {
    source = "./gatways"
    vpc-id = module.vpc-iti.myvpc-id
    subnet-id = module.subnet-pub-1.subnet-id
}
#EC2--------------------------------------------------------------
module "ec2-p1" {
    source = "./ec2"
    ec2-name = "public-proxy1"
    ec2-type = "t2.micro"
    image-type = "ami-00874d747dde814fa"
    subnet-id = module.subnet-pub-1.subnet-id
    SG-id = module.SG.sg-id
    vpc-id = module.vpc-iti.myvpc-id
    
    
    provisioner-proxy=[
      "sudo apt update -y",
      "sudo apt install -y nginx",
      "echo 'server { \n listen 80 default_server; \n  listen [::]:80 default_server; \n  server_name _; \n  location / { \n  proxy_pass http://${module.private-LB.dns}; \n  } \n}' > default",
      "sudo mv default /etc/nginx/sites-enabled/default",
      "sudo systemctl stop nginx",
      "sudo systemctl start nginx"
  ]
    
  
}


module "ec2-p2" {
    source = "./ec2"
    ec2-name = "public-proxy1"
    ec2-type = "t2.micro"
    image-type = "ami-00874d747dde814fa"
    subnet-id = module.subnet-pub-2.subnet-id
    SG-id = module.SG.sg-id
    vpc-id = module.vpc-iti.myvpc-id
    
    provisioner-proxy=[
      "sudo apt update -y",
      "sudo apt install -y nginx",
      "echo 'server { \n listen 80 default_server; \n  listen [::]:80 default_server; \n  server_name _; \n  location / { \n  proxy_pass http://${module.private-LB.dns}; \n  } \n}' > default",
      "sudo mv default /etc/nginx/sites-enabled/default",
      "sudo systemctl stop nginx",
      "sudo systemctl start nginx"
  ]
    
  
}

module "ec2-priv1" {
    source = "./ec2-userData"
    ec2-name = "private-m1"
    ec2-type = "t2.micro"
    image-type = "ami-0b5eea76982371e91"
    subnet-id = module.subnet-priv-2.private-subnet-id
    SG-id = module.SG.sg-id
    vpc-id = module.vpc-iti.myvpc-id
    
  
}

module "ec2-priv2" {
    source = "./ec2-userData"
    ec2-name = "private-m2"
    ec2-type = "t2.micro"
    image-type = "ami-0b5eea76982371e91"
    subnet-id = module.subnet-priv-1.private-subnet-id
    SG-id = module.SG.sg-id
    vpc-id = module.vpc-iti.myvpc-id
    
  
}

#Load-Balancer--------------------------------------------------

module "public-LB" {
    source = "./LB"
    lb-name = "pub-LB"
    vpc-id = module.vpc-iti.myvpc-id
    subnets-id = [module.subnet-pub-1.subnet-id,module.subnet-pub-2.subnet-id]
    sg-id = [module.SG.sg-id,module.SG.sg-id]
    ec2-id1 = module.ec2-p1.ec2-id
    ec2-id2 = module.ec2-p2.ec2-id
    tg-name = "pub-tg"
  
}

module "private-LB" {
    source = "./LB"
    lb-name = "priv-LB"
    vpc-id = module.vpc-iti.myvpc-id
    subnets-id = [module.subnet-priv-1.private-subnet-id,module.subnet-priv-2.private-subnet-id]
    sg-id = [module.SG.sg-id,module.SG.sg-id]
    ec2-id1 = module.ec2-priv1.private-ec2-id
    ec2-id2 = module.ec2-priv2.private-ec2-id
    tg-name = "priv-tg"
    
  
}
