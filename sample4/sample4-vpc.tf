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

resource "aws_subnet" "app" {
  count = length(var.aws_availability_zones[var.aws_region])
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = element(var.subnet_cidrs["app"], count.index)
  availability_zone = element(var.aws_availability_zones[var.aws_region], count.index)
  map_public_ip_on_launch=true
  tags = {
    Name = element(var.subnet_name_tag["app"], count.index)
  }
}

resource "aws_subnet" "db" {
  count = length(var.aws_availability_zones[var.aws_region])
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = element(var.subnet_cidrs["db"], count.index)
  availability_zone = element(var.aws_availability_zones[var.aws_region], count.index)
  map_public_ip_on_launch=true
  tags = {
    Name = element(var.subnet_name_tag["db"], count.index)
  }
}

resource "aws_route_table" "web" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "web"
  }
}

resource "aws_route_table" "app" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "app"
  }
}

resource "aws_route_table" "db" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "db"
  }
}

resource "aws_route_table_association" "web" {
  count = length(var.aws_availability_zones[var.aws_region])
  subnet_id      = aws_subnet.web[count.index].id
  route_table_id = aws_route_table.web.id
}

resource "aws_route_table_association" "app" {
  count = length(var.aws_availability_zones[var.aws_region])
  subnet_id      = aws_subnet.app[count.index].id
  route_table_id = aws_route_table.app.id
}

resource "aws_route_table_association" "db" {
  count = length(var.aws_availability_zones[var.aws_region])
  subnet_id      = aws_subnet.db[count.index].id
  route_table_id = aws_route_table.db.id
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "sample4-igw"
  }
}

resource "aws_eip" "nat_gateway" {
  vpc        = true
  depends_on = [aws_internet_gateway.igw]
  tags = {
    Name    = "sample4-nat-eip"
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_gateway.id
  subnet_id     = aws_subnet.web[0].id
  depends_on    = [aws_internet_gateway.igw]

  tags = {
    Name    = "sample4-nat-gw"
  }
}

resource "aws_route" "web" {
  route_table_id         = aws_route_table.web.id
  gateway_id             = aws_internet_gateway.igw.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route" "app" {
  route_table_id         = aws_route_table.app.id
  nat_gateway_id         = aws_nat_gateway.nat_gateway.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route" "db" {
  route_table_id         = aws_route_table.db.id
  nat_gateway_id         = aws_nat_gateway.nat_gateway.id
  destination_cidr_block = "0.0.0.0/0"
}

