// Create a public subnet in the first availability zone.
resource "aws_subnet" "public_a" {
  availability_zone = "${data.aws_availability_zone.a.name}"
  cidr_block        = "10.0.10.0/24"
  vpc_id            = "${aws_vpc.main.id}"
  tags {
    Name = "Public-A"
  }
}

// Create a public subnet in the second availability zone.
resource "aws_subnet" "public_b" {
  availability_zone = "${data.aws_availability_zone.b.name}"
  cidr_block        = "10.0.20.0/24"
  vpc_id            = "${aws_vpc.main.id}"
  tags {
    Name = "Public-B"
  }
}

// Create a private subnet in the first availability zone.
resource "aws_subnet" "private_a" {
  availability_zone = "${data.aws_availability_zone.a.name}"
  cidr_block        = "10.0.11.0/24"
  vpc_id            = "${aws_vpc.main.id}"
  tags {
    Name = "Private-A"
  }
}

// Create a private subnet in the second availability zone.
resource "aws_subnet" "private_b" {
  availability_zone = "${data.aws_availability_zone.b.name}"
  cidr_block        = "10.0.21.0/24"
  vpc_id            = "${aws_vpc.main.id}"
  tags {
    Name = "Private-B"
  }
}
