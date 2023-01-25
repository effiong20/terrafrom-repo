//vpc projecte
locals {
  stage = "env-stage"
}
provider "aws" {
   region     = "us-east-1"
   access_key = "AKIA45KFE7XOQ6PAKUFR"
   secret_key = "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"
}
resource "aws_vpc" "vpcstack" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = "true"

tags = {
    Name = "${local.stage}-vpcstack"
  }
}
resource "aws_subnet" "public1" {
  vpc_id     = aws_vpc.vpcstack.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = "true"
  tags = {
    Name = "${local.stage}-public1"
  }
}
resource "aws_subnet" "public2" {
  vpc_id     = aws_vpc.vpcstack.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "${local.stage}-public2"
  }
}
resource "aws_subnet" "private1a" {
  vpc_id     = aws_vpc.vpcstack.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1c"
  map_public_ip_on_launch = "false"
  
  tags = {
    Name = "${local.stage}-private1"
  }
}
resource "aws_subnet" "private1b" {
  vpc_id     = aws_vpc.vpcstack.id
  cidr_block = "10.0.3.0/24"
  availability_zone       = "us-east-1d"
  map_public_ip_on_launch = "false"
  
  tags = {
    Name = "${local.stage}-private2"
  }
}
resource "aws_internet_gateway" "gw" {
  vpc_id   = aws_vpc.vpcstack.id

  tags     = {
    Name   = "${local.stage}-gw"
  }
}

resource "aws_route_table" "public_rout" {
  vpc_id = aws_vpc.vpcstack.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
 tags = {
    Name = "${local.stage}-pub-rout"
   }
}

resource "aws_route_table" "private_rout" {
  vpc_id = aws_vpc.vpcstack.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "${local.stage}-private-rout"
  }
}

resource "aws_route_table_association" "public-associat1" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.public_rout.id
}

resource "aws_route_table_association" "public-associat" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.public_rout.id
}

resource "aws_route_table_association" "private-associat1" {
  subnet_id      = aws_subnet.private1a.id
  route_table_id = aws_route_table.private_rout.id
}
resource "aws_route_table_association" "private-associat2" {
  subnet_id      = aws_subnet.private1b.id
  route_table_id = aws_route_table.private_rout.id
}

