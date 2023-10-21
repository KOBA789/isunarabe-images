resource "aws_security_group" "builder" {
  vpc_id      = aws_default_vpc.default.id
  description = "for image builder"
  name        = "builder"
  tags = {
    Name = "builder"
  }
}

resource "aws_security_group_rule" "builder_egress" {
  security_group_id        = aws_security_group.builder.id
  type                     = "egress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = null
  cidr_blocks              = ["0.0.0.0/0"]
  description              = "allow all egress traffic"
}
