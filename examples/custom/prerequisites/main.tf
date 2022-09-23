resource "tls_private_key" "default" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "default" {
  key_name   = "my-custom-key"
  public_key = tls_private_key.default.public_key_openssh
}

resource "local_file" "private" {
  filename = "id_rsa"
  content  = tls_private_key.default.private_key_openssh
}

resource "local_file" "public" {
  filename = "id_rsa.pub"
  content  = tls_private_key.default.public_key_openssh
}

resource "aws_vpc" "default" {
  cidr_block = "192.168.0.0/16"
  tags       = {
    Name  = "my-instance-vpc"
    owner = "Robert de Bock"
  }
}

resource "aws_security_group" "default" {
  name        = "my-instance-sg"
  description = "Allow traffic."
  vpc_id      = aws_vpc.default.id
  tags       = {
    Name  = "my-instance-vpc"
    owner = "Robert de Bock"
  }
}

data "aws_availability_zones" "default" {
  state = "available"
}

resource "random_shuffle" "default" {
  input        = data.aws_availability_zones.default.names
  result_count = 1
}

resource "aws_subnet" "default" {
  vpc_id            = aws_vpc.default.id
  cidr_block        = cidrsubnet(aws_vpc.default.cidr_block, 8, 23)
  availability_zone = random_shuffle.default.result[0]
  tags       = {
    Name  = "my-instance-vpc"
    owner = "Robert de Bock"
  }
}

resource "aws_route_table" "default" {
  vpc_id = aws_vpc.default.id
  tags       = {
    Name  = "my-instance-vpc"
    owner = "Robert de Bock"
  }
}

resource "aws_route" "default" {
  route_table_id         = aws_route_table.default.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.default.id
}

resource "aws_route_table_association" "default" {
  subnet_id      = aws_subnet.default.id
  route_table_id = aws_route_table.default.id
}

resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.default.id
  tags = {
    Name  = "my-instance-vpc"
    owner = "Robert de Bock"
  }
}