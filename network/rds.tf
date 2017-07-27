// Create a subnet group consisting of the private subnets.
resource "aws_db_subnet_group" "private" {
  subnet_ids = ["${aws_subnet.private_a.id}", "${aws_subnet.private_b.id}"]

  tags {
    Name = "${var.prefix}: Private Subnets"
  }
}

// Create a multi-AZ PostgreSQL instance.
resource "aws_db_instance" "postgres" {
  allocated_storage      = 5
  db_subnet_group_name   = "${aws_db_subnet_group.private.name}"
  engine                 = "postgres"
  engine_version         = "9.6.3"
  instance_class         = "db.t2.micro"
  multi_az               = false
  name                   = "${var.db_database}"
  password               = "${var.db_password}"
  publicly_accessible    = false
  skip_final_snapshot    = true
  storage_type           = "gp2"
  username               = "${var.db_username}"
  vpc_security_group_ids = ["${aws_security_group.postgres.id}"]
}
