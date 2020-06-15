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

resource "aws_lb" "sample3-lb" {
    name = var.elb_name
    subnets = [aws_subnet.public-a.id, aws_subnet.public-c.id]

    internal = false
    load_balancer_type = "application"
    security_groups = [aws_security_group.loadbalancer.id]

    tags = {
      Environment = "sample3"
    }
}
