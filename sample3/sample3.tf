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

resource "aws_subnet" "public-1a" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.subnet_cidr["public-a"]
  availability_zone = var.aws_availability_zones["a"]

  tags = {
    Name = var.subnet_name_tag["public-a"]
  }
}

resource "aws_subnet" "public-1c" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.subnet_cidr["public-c"]
  availability_zone = var.aws_availability_zones["c"]

  tags = {
    Name = var.subnet_name_tag["public-a"]
  }
}

resource "aws_subnet" "private-1a" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.subnet_cidr["private-a"]
  availability_zone = var.aws_availability_zones["a"]

  tags = {
    Name = var.subnet_name_tag["private-a"]
  }
}

resource "aws_subnet" "private-1c" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.subnet_cidr["private-c"]
  availability_zone = var.aws_availability_zones["c"]

  tags = {
    Name = var.subnet_name_tag["private-c"]
  }
}

