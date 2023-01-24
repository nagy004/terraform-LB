

#private subnet-------------------------------------------

resource "aws_subnet" "subnet-private" {
  vpc_id = var.vpc-id
  cidr_block = var.subnet-cidr
  availability_zone = var.availability_zone
  # count = length(var.subnet-cidr)
  tags = {
    Name = var.subnet-name
  }
}


#private RT--------------------------------------------



resource "aws_route_table" "private" {
  vpc_id = var.vpc-id

  route {
    cidr_block = var.RT-cidr
    gateway_id =  var.Nat-GW-id
  }

  tags = {
    Name = "private-RT"
  }
}




resource "aws_route_table_association" "b" {
  subnet_id = aws_subnet.subnet-private.id
  route_table_id = aws_route_table.private.id
}