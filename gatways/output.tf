output "inter-gateway-id" {
  value = aws_internet_gateway.example.id

  # # count = length(var.subnet-cidr)
  
}

output "nat-gateway_id" {
  value = aws_nat_gateway.nat_gateway.id

  # # count = length(var.subnet-cidr)
  
}
