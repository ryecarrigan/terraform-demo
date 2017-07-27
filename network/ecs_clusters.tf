// Create an ECS cluster for our app frontend.
resource "aws_ecs_cluster" "frontend" {
  name = "${var.prefix}_frontend"
}

// Create an ECS cluster for our backend.
resource "aws_ecs_cluster" "backend" {
  name = "${var.prefix}_backend"
}
