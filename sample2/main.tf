provider "aws" {
  profile = "default"
  version = "~> 2.0"
  region  = "ap-northeast-1"
}

resource "aws_vpc" {
  cidr_block = "10.1.0.0/16"
  instance_tenancy = "default"
  enable_dns_support = "true"
  enable_dns_hostnames = "true"
  tags {
    Name = "tf-example-vpc"
  }
}

