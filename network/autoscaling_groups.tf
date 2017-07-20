// Create an autoscaling group from the frontend ECS launch configuration into the public subnets.
resource "aws_autoscaling_group" "frontend" {
  name                 = "ecs-frontend"
  desired_capacity     = 2
  launch_configuration = "${aws_launch_configuration.frontend.id}"
  max_size             = 4
  min_size             = 2
  vpc_zone_identifier  = ["${aws_subnet.public_a.id}","${aws_subnet.public_b.id}"]

  tag {
    key                 = "Name"
    propagate_at_launch = true
    value               = "${var.prefix}: ECS Node"
  }
}

// Create an autoscaling group from the backend ECS launch configuration into the private subnets.
resource "aws_autoscaling_group" "backend" {
  name                 = "ecs-backend"
  desired_capacity     = 1
  launch_configuration = "${aws_launch_configuration.backend.id}"
  max_size             = 1
  min_size             = 1
  vpc_zone_identifier  = ["${aws_subnet.private_a.id}","${aws_subnet.private_b.id}"]

  tag {
    key                 = "Name"
    propagate_at_launch = true
    value               = "${var.prefix}: ECS Node"
  }
}
