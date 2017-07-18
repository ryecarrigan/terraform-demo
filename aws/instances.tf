// Create a NAT gateway.
resource "aws_instance" "nat" {
  ami                         = "${data.aws_ami.nat.id}"
  associate_public_ip_address = true
  instance_type               = "t2.nano"
  key_name                    = "${var.key_name}"
  security_groups             = ["${aws_security_group.ssh.id}"]
  source_dest_check           = false
  subnet_id                   = "${aws_subnet.public_a.id}"

  tags {
    Name = "NAT Gateway"
  }
}

// Create an ECS instance in the first public subnet.
resource "aws_instance" "ecs_a" {
  ami                         = "${data.aws_ami.node.id}"
  associate_public_ip_address = true
  iam_instance_profile        = "${aws_iam_instance_profile.ecs.name}"
  instance_type               = "t2.nano"
  key_name                    = "${var.key_name}"
  security_groups             = ["${aws_security_group.ssh.id}"]
  subnet_id                   = "${aws_subnet.public_a.id}"
  user_data                   = "#!/bin/bash\necho ECS_CLUSTER=${aws_ecs_cluster.web_app.name} >> /etc/ecs/ecs.config"

  tags {
    Name = "ECS Instance A"
  }
}

// Create an ECS instance in the second public subnet.
resource "aws_instance" "ecs_b" {
  ami                         = "${data.aws_ami.node.id}"
  associate_public_ip_address = false
  iam_instance_profile        = "${aws_iam_instance_profile.ecs.name}"
  instance_type               = "t2.nano"
  key_name                    = "${var.key_name}"
  security_groups             = ["${aws_security_group.ssh.id}"]
  subnet_id                   = "${aws_subnet.public_b.id}"
  user_data                   = "#!/bin/bash\necho ECS_CLUSTER=${aws_ecs_cluster.web_app.name} >> /etc/ecs/ecs.config"

  tags {
    Name = "ECS Instance B"
  }
}
