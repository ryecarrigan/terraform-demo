// Create a security group to allows HTTP traffic from anywhere to the ALB.
resource "aws_security_group" "http_public" {
  description = "Allow HTTP traffic into the ALB"
  name        = "http_public"
  vpc_id      = "${aws_vpc.primary.id}"

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
  }
}

// Create a security group to allows HTTP traffic from the VPC to the ALB.
resource "aws_security_group" "http_private" {
  description = "Allow HTTP traffic into the ALB"
  name        = "http_private"
  vpc_id      = "${aws_vpc.primary.id}"

  egress {
    cidr_blocks = ["10.0.0.0/16"]
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
  }

  ingress {
    cidr_blocks = ["10.0.0.0/16"]
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
  }
}

// Create a security group to allow HTTP/S access from the NAT instance.
resource "aws_security_group" "nat" {
  name        = "nat"
  description = "Allow HTTP/S access to the NAT instance from the private subnets."
  vpc_id      = "${aws_vpc.primary.id}"

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

// Create a security group to allow PostgreSQL traffic around the VPC.
resource "aws_security_group" "postgres" {
  name        = "postgres"
  description = "Allow PostgreSQL traffic"
  vpc_id      = "${aws_vpc.primary.id}"

  egress {
    cidr_blocks = ["10.0.0.0/16"]
    from_port   = 5432
    protocol    = "tcp"
    to_port     = 5432
  }

  ingress {
    cidr_blocks = ["10.0.0.0/16"]
    from_port   = 5432
    protocol    = "tcp"
    to_port     = 5432
  }
}

// Create a security group to restrict SSH access to originate from a provided public IP.
resource "aws_security_group" "ssh" {
  name        = "ssh-restricted"
  description = "Restrict allowed SSH connections."
  vpc_id      = "${aws_vpc.primary.id}"

  ingress {
    cidr_blocks = "${var.ssh_cidr}"
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
  }

  egress {
    cidr_blocks = "${var.ssh_cidr}"
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
  description = "Allow outbound traffic from VPC instances to anywhere."
  vpc_id      = "${aws_vpc.primary.id}"

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
