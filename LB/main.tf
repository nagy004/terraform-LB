# Create a load balancer
resource "aws_lb" "pub-LB" {
  name            = var.lb-name
  internal        = false
  load_balancer_type = "application"
  security_groups = var.sg-id
  subnets         = var.subnets-id
}

resource "aws_lb_listener" "example" {
  load_balancer_arn =aws_lb.pub-LB.arn
  protocol = "HTTP"
  port = "80"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.public-target-group.arn
  }
}
#target groups--------------------------------------------------

resource "aws_lb_target_group" "public-target-group" {
  name = var.tg-name
  port = "80"
  protocol = "HTTP"
  vpc_id = var.vpc-id
}

# resource "aws_lb_target_group" "private-target-group" {
#   name = "priv-target-group"
#   port = "80"
#   protocol = "HTTP"
#   vpc_id = var.vpc-id
# }


resource "aws_lb_target_group_attachment" "attach-pub-ec2-1" {
  target_group_arn = aws_lb_target_group.public-target-group.arn
  target_id        = var.ec2-id1
  port             = 80
}

resource "aws_lb_target_group_attachment" "attach-pub-ec2-2" {
  target_group_arn = aws_lb_target_group.public-target-group.arn
  target_id        = var.ec2-id2
  port             = 80
}