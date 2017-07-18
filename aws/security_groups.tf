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
}
