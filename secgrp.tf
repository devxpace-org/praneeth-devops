resource "aws_security_group" "alb-sg" {
  name   = "alb-sg"
  vpc_id = aws_vpc.myvpc.id

  dynamic "ingress" {
    description = "HTTP, HTTPS from Internet"
    iterator = port
    for_each = var.ingressrules
    content{
    from_port   = port.value
    to_port     = port.value
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "asg-sg" {
  name   = "asg-sg"
  vpc_id = aws_vpc.myvpc.id

  dynamic "ingress" {
    description     = "HTTP, HTTPS from ALB"
    iterator = port
    for_each = var.ingressrules
    content {
    from_port       = port.value
    to_port         = port.value
    protocol        = "tcp"
    security_groups = [aws_security_group.alb-sg.id]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
