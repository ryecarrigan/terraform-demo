// Create a security group to allow HTTP/S access from the NAT instance.
resource "aws_security_group" "nat" {
  name        = "nat"
  description = "Allow HTTP/S access to the NAT instance from the private subnets."
  vpc_id      = "${aws_vpc.main.id}"

  egress {
    cidr_blocks = ["${aws_subnet.private_a.cidr_block}", "${aws_subnet.private_b.cidr_block}"]
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
  }

  egress {
    cidr_blocks = ["${aws_subnet.private_a.cidr_block}", "${aws_subnet.private_b.cidr_block}"]
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
  }

  ingress {
    cidr_blocks = ["${aws_subnet.private_a.cidr_block}", "${aws_subnet.private_b.cidr_block}"]
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
  }

  ingress {
    cidr_blocks = ["${aws_subnet.private_a.cidr_block}", "${aws_subnet.private_b.cidr_block}"]
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
  }

  tags {
    Name = "${var.prefix}: NAT SG"
  }
}

// Create a security group to restrict SSH access to originate from a provided public IP.
resource "aws_security_group" "ssh" {
  name        = "ssh-restricted"
  description = "Restrict allowed SSH connections."
  vpc_id      = "${aws_vpc.main.id}"

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
  }

  tags {
    Name = "${var.prefix}: SSH SG"
  }
}

// Create a security group to allow unrestricted egress around the VPC.
resource "aws_security_group" "vpc" {
  name        = "vpc-egress"
  description = "Allow egress from VPC instances to the Internet."
  vpc_id      = "${aws_vpc.main.id}"

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "tcp"
    to_port     = 65535
  }

  tags {
    Name = "${var.prefix}: VPC Egress SG"
  }
}
