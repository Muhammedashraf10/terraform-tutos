variable "aws_region" {
  type    = string
  description = "this is the regio whic"
  default = "us-east-1"
  validation {
    condition =  can(regex("^us-", var.aws_region))
    error_message = "this region is not in the USA region"
  }
}

variable "environment" {
  type = string
  description = "this is the vpc name which will be used"
  default = "myvpc-terraform"
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

variable "public_subnets_cidr" {
  type        = list(any)
  default     = ["10.0.0.0/20", "10.0.128.0/20"]
  description = "CIDR block for Public Subnet"
}

variable "private_subnets_cidr" {
  type        = list(any)
  default     = ["10.0.16.0/20", "10.0.144.0/20"]
  description = "CIDR block for Private Subnet"
}


