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
