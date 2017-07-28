// Create a NAT gateway.
resource "aws_instance" "nat" {
  ami                    = "${data.aws_ami.nat.id}"
  instance_type          = "t2.nano"
  key_name               = "${var.key_name}"
  source_dest_check      = false
  subnet_id              = "${aws_subnet.public_a.id}"
  vpc_security_group_ids = ["${aws_security_group.nat.id}", "${aws_security_group.ssh.id}", "${aws_security_group.vpc.id}"]

  tags {
    Name = "${var.prefix}: NAT Gateway"
  }
}
