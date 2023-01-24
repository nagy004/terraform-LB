# output "inter-gateway-id" {
#   value = aws_internet_gateway.example.id

#   # # count = length(var.subnet-cidr)
  
# }

output "ec2-id" {
  value = aws_instance.ec2.id

  
  
}
