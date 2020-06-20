resource "aws_security_group" "web" {
  name = "web"
  description = "allow https and http request"
  vpc_id = aws_vpc.vpc.id

}

resource "aws_security_group_rule" "inbound_web_ssh" {
  type        = "ingress"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = [
    var.subnet_cidr["public-a"],
    var.subnet_cidr["public-c"]
  ]

  security_group_id = aws_security_group.web.id
}

resource "aws_security_group_rule" "inbound_web_http" {
  type        = "ingress"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = [
    var.subnet_cidr["public-a"],
    var.subnet_cidr["public-c"]
  ]

  security_group_id = aws_security_group.web.id
}

resource "aws_security_group_rule" "outbound_web_http" {
  type        = "egress"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = [
    var.subnet_cidr["public-a"],
    var.subnet_cidr["public-c"]
  ]

  security_group_id = aws_security_group.web.id
}

resource "aws_security_group_rule" "inbound_db_https" {
  type        = "ingress"
  from_port   = 3306
  to_port     = 3306
  protocol    = "tcp"
  cidr_blocks = [
    var.subnet_cidr["db-a"],
    var.subnet_cidr["db-c"]
  ]

  security_group_id = aws_security_group.web.id
}

resource "aws_security_group_rule" "outbound_db_https" {
  type        = "egress"
  from_port   = 3306
  to_port     = 3306
  protocol    = "tcp"
  cidr_blocks = [
    var.subnet_cidr["db-a"],
    var.subnet_cidr["db-c"]
  ]

  security_group_id = aws_security_group.web.id
}

resource "aws_launch_configuration" "web_conf" {
  name          = var.lc_name
  image_id      = var.web_image_id
  instance_type = "t2.micro"
  security_groups = [aws_security_group.web.id]
}

resource "aws_autoscaling_group" "sample3_as_group" {
  name                 = "example3_as_group"
  launch_configuration = aws_launch_configuration.web_conf.name
  min_size             = 1
  max_size             = 1
  desired_capacity     = 1
  target_group_arns    = [aws_alb_target_group.sample3lb.arn]
  vpc_zone_identifier  = [aws_subnet.private-a.id, aws_subnet.private-c.id]

  lifecycle {
    create_before_destroy = true
  }
}

