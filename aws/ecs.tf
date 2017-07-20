// Create an ECS cluster for our app frontend.
resource "aws_ecs_cluster" "frontend" {
  name = "${var.prefix}_frontend"
}

// Create an ECS cluster for our backend.
resource "aws_ecs_cluster" "backend" {
  name = "${var.prefix}_backend"
}

// Create a task definition for the web app.
resource "aws_ecs_task_definition" "frontend" {
  container_definitions = "${file("task.json")}"
  family                = "service"
}

// Create the app as a frontend ECS service.
resource "aws_ecs_service" "frontend" {
  cluster         = "${aws_ecs_cluster.frontend.id}"
  desired_count   = 2
  name            = "${var.prefix}_frontend"
  task_definition = "${aws_ecs_task_definition.frontend.arn}"
}
