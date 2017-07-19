resource "aws_launch_configuration" "ecs" {
  name_prefix                 = "${var.prefix}_ecs-conf-"
  associate_public_ip_address = false
  iam_instance_profile        = "${aws_iam_instance_profile.ecs.name}"
  image_id                    = "${data.aws_ami.node.id}"
  instance_type               = "t2.nano"
  key_name                    = "${var.key_name}"
  security_groups             = ["${aws_security_group.ssh.id}", "${aws_security_group.vpc.id}"]
  user_data                   = "#!/bin/bash\necho ECS_CLUSTER=${aws_ecs_cluster.web_app.name} >> /etc/ecs/ecs.config"

  lifecycle {
    create_before_destroy = true
  }
}
