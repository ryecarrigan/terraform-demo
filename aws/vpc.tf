/*
 * Create a new VPC.
 */
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags {
    Name = "Demo VPC"
  }
}
