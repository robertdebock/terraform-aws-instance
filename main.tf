resource "aws_vpc" "default" {
  cidr_block = var.instance_aws_vpc_cidr_block
  tags       = local.tags
}

resource "aws_security_group" "default" {
  name        = var.instance_name
  description = "Allow traffic."
  vpc_id      = aws_vpc.default.id
  tags        = local.tags
}

resource "aws_security_group_rule" "tcp" {
  count             = length(var.instance_aws_security_group_rule_tcp_ports)
  type              = "ingress"
  from_port         = var.instance_aws_security_group_rule_tcp_ports[count.index]
  to_port           = var.instance_aws_security_group_rule_tcp_ports[count.index]
  protocol          = "tcp"
  cidr_blocks       = [local.internet]
  security_group_id = aws_security_group.default.id
}

resource "aws_security_group_rule" "udp" {
  count             = length(var.instance_aws_security_group_rule_udp_ports)
  type              = "ingress"
  from_port         = var.instance_aws_security_group_rule_udp_ports[count.index]
  to_port           = var.instance_aws_security_group_rule_udp_ports[count.index]
  protocol          = "udp"
  cidr_blocks       = [local.internet]
  security_group_id = aws_security_group.default.id
}

resource "aws_security_group_rule" "icmp" {
  type              = "ingress"
  from_port         = -1
  to_port           = -1
  protocol          = "icmp"
  cidr_blocks       = [local.internet]
  security_group_id = aws_security_group.default.id
}

resource "aws_security_group_rule" "internet" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = [local.internet]
  security_group_id = aws_security_group.default.id
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
  tags              = local.tags
}

resource "aws_route_table" "default" {
  vpc_id = aws_vpc.default.id
  tags   = local.tags
}

resource "aws_route" "default" {
  route_table_id         = aws_route_table.default.id
  destination_cidr_block = local.internet
  gateway_id             = aws_internet_gateway.default.id
}

resource "aws_route_table_association" "default" {
  subnet_id      = aws_subnet.default.id
  route_table_id = aws_route_table.default.id
}

resource "aws_key_pair" "default" {
  key_name   = var.instance_name
  public_key = file("id_rsa.pub")
  tags       = local.tags
}

data "aws_ami" "default" {
  most_recent = true
  filter {
    name   = "name"
    values = [local.aws_ami_name]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  owners = [local.aws_ami_owner]
}

resource "aws_instance" "default" {
  ami                         = data.aws_ami.default.id
  associate_public_ip_address = true
  instance_type               = "t3.micro"
  key_name                    = aws_key_pair.default.key_name
  subnet_id                   = aws_subnet.default.id
  vpc_security_group_ids      = [aws_security_group.default.id]
  tags                        = local.tags
  user_data                   = local.user_data
}

resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.default.id
  tags   = local.tags
}
