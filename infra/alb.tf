# Target group for the web instances
resource "aws_lb_target_group" "web_tg" {
  name     = "proj2-web-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  health_check {
    enabled             = true
    healthy_threshold   = 3
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    path                = "/"
    matcher             = "200"
  }

  tags = {
    Name = "proj2-web-tg"
  }
}

# Attach the EC2 instance to the target group
resource "aws_lb_target_group_attachment" "web_private_a" {
  target_group_arn = aws_lb_target_group.web_tg.arn
  target_id        = aws_instance.web_private_a.id
  port             = 80
}

# Application Load Balancer
resource "aws_lb" "public_alb" {
  name               = "proj2-public-alb"
  load_balancer_type = "application"
  internal           = false
  security_groups    = [aws_security_group.alb_public.id]

  subnets = [
    aws_subnet.public_a.id,
    aws_subnet.public_b.id
  ]

  tags = {
    Name = "proj2-public-alb"
  }
}

# ALB listener on HTTP 80 -> forward to target group
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.public_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_tg.arn
  }
}
