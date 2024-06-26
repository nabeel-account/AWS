# Create the Security Group Block

resource "aws_security_group" "allow_db" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.my_vpc.id

  tags = {
    Name = "allow_tls"
  }
}

# Create the security group block INGRESS Rules

## Please note, for added security, ensure you only specify the necessary cidr_ipv4 block

resource "aws_vpc_security_group_ingress_rule" "allow_3306" {
  security_group_id = aws_security_group.allow_db.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 0
  ip_protocol       = "tcp"
  to_port           = 3306
}

# Create the security group block EGRESS Rules

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_db.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}