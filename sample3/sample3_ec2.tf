resource "aws_security_group" "step" {
  name = "step"
  description = "allow https and http request"
  vpc_id = aws_vpc.vpc.id

}

resource "aws_security_group_rule" "inbound_step_ssh" {
  type        = "ingress"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = [
    "0.0.0.0/0"
  ]

  security_group_id = aws_security_group.step.id
}

resource "aws_instance" "step" {
  ami           = var.web_image_id
  instance_type = "t2.micro"
  security_groups = [aws_security_group.step.id]
  subnet_id = aws_subnet.public-a.id

  tags = {
    Name = "step_server"
  }
}