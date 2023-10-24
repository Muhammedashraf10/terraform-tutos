# VPC
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr #vpc_cidr is a variable will be retrieved from vars.tf
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "${var.environment}-vpc" #environment is variable will be retrieved from vars.tf
    Environment = var.environment
  }
}

# Public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc.id #VPC ID where the vpc is the name of our vpc created above
  count                   = length(var.public_subnets_cidr)
  cidr_block              = element(var.public_subnets_cidr, count.index)
  availability_zone       = element(local.availability_zones, count.index)
  map_public_ip_on_launch = true #Specify true to indicate that instances launched into the subnet should be assigned a public IP address. Default is false

  tags = {
    Name        = "${var.environment}-${element(local.availability_zones, count.index)}-public-subnet"
    Environment = "${var.environment}"
  }
}

# Private Subnet
resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  count                   = length(var.private_subnets_cidr)
  cidr_block              = element(var.private_subnets_cidr, count.index)
  availability_zone       = element(local.availability_zones, count.index)
  map_public_ip_on_launch = false

  tags = {
    Name        = "${var.environment}-${element(local.availability_zones, count.index)}-private-subnet"
    Environment = "${var.environment}"
  }
}
