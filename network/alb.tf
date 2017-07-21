// Create an ALB target group for the frontend.
resource "aws_alb_target_group" "frontend" {
  name     = "${var.prefix}-frontend"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.primary.id}"

  health_check {
    path = "/health.php"
  }
}

// Create an ALB target group for the backend.
resource "aws_alb_target_group" "backend" {
  name     = "${var.prefix}-backend"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.primary.id}"

  health_check {
    path = "/health.php"
  }
}

// Create the ALB in the public subnets for the frontend.
resource "aws_alb" "frontend" {
  name            = "${var.prefix}-frontend"
  subnets         = ["${aws_subnet.public_a.id}", "${aws_subnet.public_b.id}"]
  security_groups = ["${aws_security_group.http_public.id}"]
}

// Create the ALB in the private subnets for the backend.
resource "aws_alb" "backend" {
  name            = "${var.prefix}-backend"
  subnets         = ["${aws_subnet.private_a.id}", "${aws_subnet.private_b.id}"]
  security_groups = ["${aws_security_group.http_private.id}"]
}

// Create the ALB listener for the frontend.
resource "aws_alb_listener" "frontend" {
  load_balancer_arn = "${aws_alb.frontend.arn}"
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.frontend.id}"
    type             = "forward"
  }
}

// Create the ALB listener for the backend.
resource "aws_alb_listener" "backend" {
  load_balancer_arn = "${aws_alb.backend.arn}"
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.backend.id}"
    type             = "forward"
  }
}
