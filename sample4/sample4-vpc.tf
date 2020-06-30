provider "aws" {
  profile = "default"
  region  = var.aws_region
}

resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  instance_tenancy = "default"
  enable_dns_support = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "web" {
  count = length(var.aws_availability_zones[var.aws_region])
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = element(var.subnet_cidrs["web"], count.index)
  availability_zone = element(var.aws_availability_zones[var.aws_region], count.index)
  map_public_ip_on_launch=true
  tags = {
    Name = element(var.subnet_name_tag["web"], count.index)
  }
}



