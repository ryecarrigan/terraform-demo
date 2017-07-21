// Create an IAM role for ECS instances.
resource "aws_iam_role" "ecs_instance" {
  name               = "${var.prefix}_EcsInstanceRole"
  assume_role_policy = "${file("network/instance_role_trust.json")}"
}

// Create an instance profile for applying the IAM role to ECS instances.
resource "aws_iam_instance_profile" "ecs_instance" {
  name = "${var.prefix}_EcsInstanceProfile"
  role = "${aws_iam_role.ecs_instance.name}"
}

// Attach the ECS instance policy to the role.
resource "aws_iam_role_policy" "ecs_instance" {
  name   = "${var.prefix}_EcsInstancePolicy"
  policy = "${file("network/instance_role_policy.json")}"
  role   = "${aws_iam_role.ecs_instance.id}"
}

// Create an IAM role for ECS services.
resource "aws_iam_role" "ecs_service" {
  name               = "${var.prefix}"
  assume_role_policy = "${file("network/service_role_trust.json")}"
}

// Attach the ECS service policy to the role.
resource "aws_iam_role_policy" "ecs_service" {
  name   = "${var.prefix}_EcsServiceRole"
  policy = "${file("network/service_role_policy.json")}"
  role   = "${aws_iam_role.ecs_service.id}"
}
