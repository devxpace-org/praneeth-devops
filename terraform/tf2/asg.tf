resource "aws_lb" "alb" {
  name               = "mytest-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = [for subnet in aws_subnet.public-subnets : subnet.id]
  security_groups    = [aws_security_group.alb-sg.id]
}

resource "aws_lb_target_group" "tg1" {
  name     = "mytest-tg1"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.myvpc.id
}

resource "aws_lb_listener" "alb-listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg1.arn
  }
}

resource "aws_launch_template" "launchtemplate1" {
  name                   = "mytest-launchtemplate1"
  image_id               = var.AMIS[var.REGION]
  instance_type          = "t2.micro"
  key_name               = "praneeth"
  vpc_security_group_ids = [aws_security_group.asg-sg.id]
  tags = {
    App = var.APP
  }
  user_data = base64encode("${var.USERDATA}")
}

resource "aws_autoscaling_group" "asg1" {
  name                = "mytest-asg1"
  max_size            = 3
  min_size            = 1
  desired_capacity    = 2
  vpc_zone_identifier = [for subnet in aws_subnet.private-subnets[*] : subnet.id]
  target_group_arns   = [aws_lb_target_group.tg1.arn]

  launch_template {
    id      = aws_launch_template.launchtemplate1.id
    version = "$Latest"
  }
}

output "mytest-alb-dns-name" {
  value = aws_lb.alb.dns_name
}