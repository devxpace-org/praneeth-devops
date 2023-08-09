resource "aws_vpc" "myvpc" {
  cidr_block           = var.VPC_CIDR
  enable_dns_hostnames = "true"
  tags = {
    Name = "mytest-vpc"
    App  = var.APP
  }
}

resource "aws_subnet" "public-subnets" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = var.PUBLIC_SUBNETS_CIDR[count.index]
  count                   = var.PUB_SUBNETS_COUNT
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = "true"
  tags = {
    Name = "mytest-pub-sub"
    App  = var.APP
  }
}

resource "aws_subnet" "private-subnets" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = var.PRIVATE_SUBNETS_CIDR[count.index]
  count                   = var.PRIV_SUBNETS_COUNT
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = "true"
  tags = {
    Name = "mytest-priv-sub"
    App  = var.APP
  }
}

resource "aws_internet_gateway" "myvpc-igw" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name = "mytest-igw"
    App  = var.APP
  }
}

resource "aws_route_table" "pub-RT" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myvpc-igw.id
  }

  tags = {
    Name = "mytest-pub-RT"
    App  = var.APP
  }
}

resource "aws_route_table_association" "public-subnets-rt-a" {
  count          = var.PUB_SUBNETS_COUNT
  subnet_id      = aws_subnet.public-subnets[count.index].id
  route_table_id = aws_route_table.pub-RT.id
}

resource "aws_eip" "myvpc_eip" {
  depends_on = [aws_internet_gateway.myvpc-igw]
  domain     = "vpc"
}

resource "aws_nat_gateway" "myvpc-natgw" {
  allocation_id     = aws_eip.myvpc_eip.id
  connectivity_type = "public"
  subnet_id         = aws_subnet.public-subnets[0].id

  tags = {
    Name = "mytest-natgw"
    App  = var.APP
  }
}

resource "aws_route_table" "priv-RT" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.myvpc-natgw.id
  }

  tags = {
    Name = "mytest-priv-RT"
    App  = var.APP
  }
}

resource "aws_route_table_association" "private-subnets-rt-a" {
  count          = var.PRIV_SUBNETS_COUNT
  subnet_id      = aws_subnet.private-subnets[count.index].id
  route_table_id = aws_route_table.priv-RT.id
}