// Create a network ACL for the public subnets.
resource "aws_network_acl" "public" {
  subnet_ids = ["${aws_subnet.public_a.id}", "${aws_subnet.public_b.id}"]
  vpc_id     = "${aws_vpc.primary.id}"

  egress {
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    protocol   = "tcp"
    rule_no    = 100
    to_port    = 80
  }

  ingress {
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    protocol   = "tcp"
    rule_no    = 100
    to_port    = 80
  }

  tags {
    Name = "${var.prefix}: Public NACL"
  }
}
