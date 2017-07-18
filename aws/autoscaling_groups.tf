resource "aws_autoscaling_group" "ecs" {
  name                 = "ecs-nodes"
  desired_capacity     = 2
  launch_configuration = "${aws_launch_configuration.ecs.id}"
  max_size             = 2
  min_size             = 2
  vpc_zone_identifier  = ["${aws_subnet.private_a.id}","${aws_subnet.private_b.id}"]

  tag {
    key                 = "Name"
    propagate_at_launch = true
    value               = "${var.prefix}: ECS Node"
  }
}
