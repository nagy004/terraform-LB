output "subnet-id" {
  value = aws_subnet.myvpc_subnet.id
  # count = length(var.subnet-cidr)
  
}
