resource "aws_lb" "tyagi_alb" {
  name               = "tyagi-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = aws_subnet.tyagi_subnet[*].id
  security_groups    = [aws_security_group.tyagi_alb_sg.id]
  tags = {
    Name = "tyagi-alb"
  }
}

resource "aws_lb_target_group" "tyagi_tg" {
  name        = "tyagi-tg"
  port        = 1337
  protocol    = "HTTP"
  vpc_id      = aws_vpc.tyagi_vpc.id
  target_type = "ip"  # ✅ Required for Fargate + awsvpc

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200-399"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "tyagi-tg"
  }
}

resource "aws_lb_listener" "tyagi_listener" {
  load_balancer_arn = aws_lb.tyagi_alb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tyagi_tg.arn
  }
}
