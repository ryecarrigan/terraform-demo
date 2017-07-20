resource "aws_eip" "nat" {
  instance = "${aws_instance.nat.id}"
  vpc      = true
}
