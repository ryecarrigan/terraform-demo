// Create the service for the frontend.
resource "aws_ecs_service" "frontend" {
  cluster         = "${aws_ecs_cluster.frontend.id}"
  desired_count   = 2
  iam_role        = "${aws_iam_role.ecs_service.arn}"
  name            = "${var.prefix}_frontend"
  task_definition = "${aws_ecs_task_definition.frontend.arn}"

  load_balancer {
    container_name   = "frontend"
    container_port   = 80
    target_group_arn = "${aws_alb_target_group.frontend.arn}"
  }
}

// Create the service for the backend.
resource "aws_ecs_service" "backend" {
  cluster         = "${aws_ecs_cluster.backend.id}"
  desired_count   = 2
  iam_role        = "${aws_iam_role.ecs_service.arn}"
  name            = "${var.prefix}_backend"
  task_definition = "${aws_ecs_task_definition.backend.arn}"

  load_balancer {
    container_name   = "backend"
    container_port   = 80
    target_group_arn = "${aws_alb_target_group.backend.arn}"
  }
}
