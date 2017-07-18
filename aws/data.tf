// Set the AWS region.
provider "aws" {
  region = "${var.region}"
}

// Identify the latest ECS-optimized AMI.
data "aws_ami" "node" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn-*-ecs-optimized"]
  }
}

// Identify the latest VPC NAT instance AMI.
data "aws_ami" "nat" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn-ami-vpc-nat*"]
  }
}

// Identify the availability zones in this region.
data "aws_availability_zones" "available" {}

// Identify the name of the first availablility zone.
data "aws_availability_zone" "a" {
  name = "${data.aws_availability_zones.available.names[0]}"
}

// Identify the name of the second availability zone.
data "aws_availability_zone" "b" {
  name = "${data.aws_availability_zones.available.names[1]}"
}
