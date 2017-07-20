resource "aws_iam_instance_profile" "ecs" {
  name = "${var.prefix}_EcsInstanceProfile"
  role = "${aws_iam_role.ecs.name}"
}

resource "aws_iam_role" "ecs" {
  name               = "${var.prefix}_EcsInstanceRole"
  assume_role_policy = "${file("assume_role_policy.json")}"
}

resource "aws_iam_role_policy" "ecs" {
  name   = "${var.prefix}_EcsInstancePolicy"
  role   = "${aws_iam_role.ecs.id}"
  policy = "${file("role_policy.json")}"
}
