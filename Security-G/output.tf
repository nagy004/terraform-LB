output "sg-id" {
  value = aws_security_group.SG.id
  # count = length(var.subnet-cidr)
  
}
