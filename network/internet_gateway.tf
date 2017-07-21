// Create an Internet gateway to connect the VPC to the Internet and the rest of AWS.
resource "aws_internet_gateway" "primary" {
  vpc_id = "${aws_vpc.primary.id}"

  tags {
    Name = "${var.prefix}: Internet Gateway"
  }
}
