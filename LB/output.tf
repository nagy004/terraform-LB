output "myvpc-id" {
  value = aws_lb.pub-LB.dns_name
}
