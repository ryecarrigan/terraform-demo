// Create a variable to store the key name for instances.
variable "key_name" {
  type    = "string"
  default = "rypcarr-ca-central"
}

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
