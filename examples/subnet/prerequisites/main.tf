resource "aws_vpc" "default" {
  cidr_block = "10.0.0.0/16"
  tags       = {
    Name = "subnet"
    owner = "Robert de Bock"
  }
}

resource "aws_security_group" "default" {
  name        = "subnet"
  description = "Allow traffic."
  vpc_id      = aws_vpc.default.id
  tags       = {
    Name = "subnet"
    owner = "Robert de Bock"
  }
}

resource "aws_security_group_rule" "tcp" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.default.id
}

resource "aws_security_group_rule" "icmp" {
  type              = "ingress"
  from_port         = -1
  to_port           = -1
  protocol          = "icmp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.default.id
}

resource "aws_security_group_rule" "internet" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.default.id
}

data "aws_availability_zones" "default" {
  state = "available"
  exclude_names = ["us-east-1e"]
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
    Name = "subnet"
    owner = "Robert de Bock"
  }
}

resource "aws_route_table" "default" {
  vpc_id = aws_vpc.default.id
  tags       = {
    Name = "subnet"
    owner = "Robert de Bock"
  }
}
resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.default.id
  tags       = {
    Name = "subnet"
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
