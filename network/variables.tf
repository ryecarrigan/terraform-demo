// Create variables for the database name, username, and password
variable "db_database" {}
variable "db_password" {}
variable "db_username" {}

// Create a variable to store the key name for instances.
variable "key_name" {}

// Common prefix for all generated resources.
variable "prefix" {
  type    = "string"
  default = "tf-demo"
}

// Create a variable for the AWS region.
variable "region" {
  type    = "string"
  default = "ca-central-1"
}

// Create a variable for the required origin for SSH connections.
variable "ssh_cidr" {
  type    = "list"
  default = ["10.0.0.0/16"]
}
