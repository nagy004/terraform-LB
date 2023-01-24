# Create a VPC
resource "aws_vpc" "myvpc" {
  cidr_block = var.vpc-cidr[0]
  tags = {
    "Name" = var.vpc-name
  }
 
}

#gatways----------------------------------------

