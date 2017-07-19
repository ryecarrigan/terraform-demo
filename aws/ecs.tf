// Create an ECS cluster for our Dockerized app.
resource "aws_ecs_cluster" "web_app" {
  name = "${var.prefix}_ECS-Cluster"
}

// Create a task definition for the web app.
resource "aws_ecs_task_definition" "web_app" {
  container_definitions = "${file("task.json")}"
  family                = "service"
}

// Create the app as an ECS service.
resource "aws_ecs_service" "web_app" {
  cluster         = "${aws_ecs_cluster.web_app.id}"
  desired_count   = 2
  name            = "${var.prefix}_WebApp"
  task_definition = "${aws_ecs_task_definition.web_app.arn}"
}
