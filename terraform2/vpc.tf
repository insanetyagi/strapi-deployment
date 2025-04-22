resource "aws_vpc" "tyagi_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "tyagi-vpc"
  }
}

resource "aws_internet_gateway" "tyagi_igw" {
  vpc_id = aws_vpc.tyagi_vpc.id
  tags = {
    Name = "tyagi-igw"
  }
}

resource "aws_subnet" "tyagi_subnet" {
  count                   = length(var.public_subnets)
  vpc_id                  = aws_vpc.tyagi_vpc.id
  cidr_block              = var.public_subnets[count.index]
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  tags = {
    Name = "tyagi-subnet-${count.index}"
  }
}

data "aws_availability_zones" "available" {}

resource "aws_route_table" "tyagi_rt" {
  vpc_id = aws_vpc.tyagi_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tyagi_igw.id
  }
  tags = {
    Name = "tyagi-rt"
  }
}

resource "aws_route_table_association" "tyagi_rt_assoc" {
  count          = length(aws_subnet.tyagi_subnet)
  subnet_id      = aws_subnet.tyagi_subnet[count.index].id
  route_table_id = aws_route_table.tyagi_rt.id
}
