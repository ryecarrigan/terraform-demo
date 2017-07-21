// Allocate an elastic IP for the NAT instance.
resource "aws_eip" "nat" {
  instance = "${aws_instance.nat.id}"
  vpc      = true
}
