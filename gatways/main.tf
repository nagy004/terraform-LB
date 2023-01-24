resource "aws_internet_gateway" "example" {
  vpc_id =var.vpc-id
}



resource "aws_eip" "example" {
  vpc = true
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.example.id
  subnet_id     = var.subnet-id
}