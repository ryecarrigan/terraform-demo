// Create an ALB target group for HTTP.
resource "aws_alb_target_group" "public" {
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.primary.id}"
}

// Create the ALB in the public subnets for the frontend.
resource "aws_alb" "public" {
  subnets         = ["${aws_subnet.public_a.id}", "${aws_subnet.public_b.id}"]
  security_groups = ["${aws_security_group.alb.id}"]
}

// Create the ALB listener for the frontend.
resource "aws_alb_listener" "public" {
  load_balancer_arn = "${aws_alb.public.arn}"
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.public.id}"
    type             = "forward"
  }
}
