// Create an Internet gateway to connect the VPC to the Internet and the rest of AWS.
resource "aws_internet_gateway" "main" {
  vpc_id = "${aws_vpc.main.id}"
}
