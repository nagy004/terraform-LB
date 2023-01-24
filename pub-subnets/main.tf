resource "aws_subnet" "myvpc_subnet" { #==>>this is my public subnet 
  vpc_id = var.vpc-id
  cidr_block = var.subnet-cidr
  availability_zone = var.availability_zone
  # count = length(var.subnet-cidr)
  tags = {
    Name = var.subnet-name
  }
}

#public routing table
resource "aws_route_table" "public" {
   vpc_id = var.vpc-id

  route {
    cidr_block = var.RT-cidr
    gateway_id = var.internet-GW-id
  }
    tags = {
    Name = "public-RT"
  }
}


resource "aws_route_table_association" "example" {
  subnet_id = aws_subnet.myvpc_subnet.id
  route_table_id = aws_route_table.public.id
}