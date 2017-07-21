// Create a launch configuration for the frontend.
resource "aws_launch_configuration" "frontend" {
  name_prefix                 = "${var.prefix}_frontend-"
  associate_public_ip_address = true
  iam_instance_profile        = "${aws_iam_instance_profile.ecs_instance.name}"
  image_id                    = "${data.aws_ami.node.id}"
  instance_type               = "t2.nano"
  key_name                    = "${var.key_name}"
  security_groups             = [
    "${aws_security_group.http_public.id}",
    "${aws_security_group.ssh.id}",
    "${aws_security_group.postgres.id}",
    "${aws_security_group.vpc.id}",
  ]
  user_data                   = "#!/bin/bash\necho ECS_CLUSTER=${aws_ecs_cluster.frontend.name} >> /etc/ecs/ecs.config"

  lifecycle {
    create_before_destroy = true
  }
}

// Create a launch configuration for the backend.
resource "aws_launch_configuration" "backend" {
  name_prefix                 = "${var.prefix}_backend-"
  associate_public_ip_address = false
  iam_instance_profile        = "${aws_iam_instance_profile.ecs_instance.name}"
  image_id                    = "${data.aws_ami.node.id}"
  instance_type               = "t2.nano"
  key_name                    = "${var.key_name}"
  security_groups             = [
    "${aws_security_group.http_private.id}",
    "${aws_security_group.ssh.id}",
    "${aws_security_group.postgres.id}",
    "${aws_security_group.vpc.id}"
  ]
  user_data                   = "#!/bin/bash\necho ECS_CLUSTER=${aws_ecs_cluster.backend.name} >> /etc/ecs/ecs.config"

  lifecycle {
    create_before_destroy = true
  }
}
