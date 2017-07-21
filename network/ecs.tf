// Create an ECS cluster for our app frontend.
resource "aws_ecs_cluster" "frontend" {
  name = "${var.prefix}_frontend"
}

// Create an ECS cluster for our backend.
resource "aws_ecs_cluster" "backend" {
  name = "${var.prefix}_backend"
}

// Create a task definition for the frontend service.
resource "aws_ecs_task_definition" "frontend" {
  container_definitions = <<EOF
[
  {
    "name": "frontend",
    "image": "rypcarr/tf-demo-frontend",
    "cpu": 512,
    "memory": 128,
    "environment": [
      {"name": "BACKEND_HOST", "value": "${aws_alb.backend.dns_name}"}
    ],
    "essential": true,
    "portMappings": [
      {
        "containerPort": 80,
        "hostPort": 80
      }
    ]
  }
]
EOF

  family = "frontend"
}

// Create a task definition for the backend service.
resource "aws_ecs_task_definition" "backend" {
  container_definitions = <<EOF
[
  {
    "name": "backend",
    "image": "rypcarr/tf-demo-backend",
    "cpu": 512,
    "memory": 128,
    "environment": [
      {"name": "POSTGRES_HOST", "value": "${aws_db_instance.postgres.address}"},
      {"name": "POSTGRES_DB", "value": "${var.db_database}"},
      {"name": "POSTGRES_USER", "value": "${var.db_username}"},
      {"name": "POSTGRES_PASSWORD", "value": "${var.db_password}"}
    ],
    "essential": true,
    "portMappings": [
      {
        "containerPort": 80,
        "hostPort": 80
      }
    ]
  }
]
EOF

  family = "backend"
}

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
