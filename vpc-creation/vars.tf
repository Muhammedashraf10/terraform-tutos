variable "aws_region" {
  default = "us-east-1"
}
variable "environment" {
  default = "javatodev"
}
variable "vpc_cidr" {
  default     = "10.0.0.0/16"
  description = "CIDR block of the vpc"
}
provider "aws" {
  region = var.aws_region
}
locals {
  availability_zones = ["${var.aws_region}a", "${var.aws_region}b"]
}
