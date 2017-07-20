// Create a route table for the public subnets with direct access to the Internet.
resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.primary.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.primary.id}"
  }

  tags {
    Name = "${var.prefix}: Public-RT"
  }
}

// Associate the public route table with the first public subnet.
resource "aws_route_table_association" "public_a" {
  route_table_id = "${aws_route_table.public.id}"
  subnet_id      = "${aws_subnet.public_a.id}"
}

// Associate the public route table with the second public subnet.
resource "aws_route_table_association" "public_b" {
  route_table_id = "${aws_route_table.public.id}"
  subnet_id      = "${aws_subnet.public_b.id}"
}

// Create a route table for the private subnets to access the NAT instance in the public subnet.
resource "aws_route_table" "private" {
  vpc_id = "${aws_vpc.primary.id}"

  route {
    cidr_block  = "0.0.0.0/0"
    instance_id = "${aws_instance.nat.id}"
  }

  tags {
    Name = "${var.prefix}: Private-RT"
  }
}

// Associate the private route table with the first private subnet.
resource "aws_route_table_association" "private_a" {
  route_table_id = "${aws_route_table.private.id}"
  subnet_id      = "${aws_subnet.private_a.id}"
}

// Associate the private route table with the first private subnet.
resource "aws_route_table_association" "private_b" {
  route_table_id = "${aws_route_table.private.id}"
  subnet_id      = "${aws_subnet.private_b.id}"
}
