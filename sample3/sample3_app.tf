resource "aws_security_group" "loadbalancer" {
  name = "loadbalancer"
  description = "allow https and http request"
  vpc_id = aws_vpc.vpc.id

}

resource "aws_security_group_rule" "inbound_http" {
  type        = "ingress"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = [
    "0.0.0.0/0"
  ]

  security_group_id = aws_security_group.loadbalancer.id
}

resource "aws_security_group_rule" "inbound_https" {
  type        = "ingress"
  from_port   = 443
  to_port     = 443
  protocol    = "tcp"
  cidr_blocks = [
    "0.0.0.0/0"
  ]

  security_group_id = aws_security_group.loadbalancer.id
}
resource "aws_alb_target_group" "sample3lb" {
  name = var.tg_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id

  health_check {
    interval            = 30
    path                = "/index.html"
    port                = 80
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
    matcher             = 200
  }
}

# resource "aws_alb_target_group_attachment" "sample3-lb" {
#   count            = 2
#   target_group_arn = aws_alb_target_group.sample3-lb.*.arn
#   target_id        = aws_spot_instance_request.web.*.spot_instance_id
#   port             = 80
# }

resource "aws_alb" "sample3lb" {
    name = var.elb_name
    subnets = [aws_subnet.public-a.id, aws_subnet.public-c.id]

    internal = false
    load_balancer_type = "application"
    security_groups = [aws_security_group.loadbalancer.id]

    tags = {
      Environment = "sample3"
    }
}

resource "aws_alb_listener" "sample3lb" {
  load_balancer_arn = aws_alb.sample3lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.sample3lb.arn
    type             = "forward"
  }
}
