resource "aws_vpc" "default" {
  count      = var.instance_aws_vpc_id == null ? 1 : 0
  cidr_block = var.instance_aws_vpc_cidr_block
  tags       = local.tags
}

data "aws_vpc" "default" {
  count = var.instance_aws_vpc_id == null ? 0 : 1
  id    = var.instance_aws_vpc_id
}

resource "aws_security_group" "default" {
  count       = var.instance_aws_security_group_id == null ? 1 : 0
  description = "Allow traffic."
  vpc_id      = local.vpc_id
  tags        = local.tags
}

data "aws_security_group" "default" {
  count = var.instance_aws_security_group_id == null ? 0 : 1
  id    = var.instance_aws_security_group_id
}

resource "aws_security_group_rule" "tcp" {
  count             = var.instance_aws_security_group_id == null ? length(var.instance_aws_security_group_rule_tcp_ports) : 0
  type              = "ingress"
  from_port         = var.instance_aws_security_group_rule_tcp_ports[count.index]
  to_port           = var.instance_aws_security_group_rule_tcp_ports[count.index]
  protocol          = "tcp"
  cidr_blocks       = [local.internet]
  security_group_id = aws_security_group.default[0].id
}

resource "aws_security_group_rule" "udp" {
  count             = var.instance_aws_security_group_id == null ? length(var.instance_aws_security_group_rule_udp_ports) : 0
  type              = "ingress"
  from_port         = var.instance_aws_security_group_rule_udp_ports[count.index]
  to_port           = var.instance_aws_security_group_rule_udp_ports[count.index]
  protocol          = "udp"
  cidr_blocks       = [local.internet]
  security_group_id = aws_security_group.default[0].id
}

resource "aws_security_group_rule" "icmp" {
  count             = var.instance_aws_security_group_id == null ? 1 : 0
  type              = "ingress"
  from_port         = -1
  to_port           = -1
  protocol          = "icmp"
  cidr_blocks       = [local.internet]
  security_group_id = aws_security_group.default[0].id
}

resource "aws_security_group_rule" "internet" {
  count             = var.instance_aws_security_group_id == null ? 1 : 0
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = [local.internet]
  security_group_id = aws_security_group.default[0].id
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
  count             = length(aws_vpc.default)
  vpc_id            = local.vpc_id
  cidr_block        = cidrsubnet(aws_vpc.default[0].cidr_block, 8, 23)
  availability_zone = local.availability_zone
  tags              = local.tags
}

data "aws_subnet" "default" {
  count = var.instance_aws_subnet_id == null ? 0 : 1
  id    = var.instance_aws_subnet_id
}

resource "aws_route_table" "default" {
  count  = length(aws_vpc.default)
  vpc_id = local.vpc_id
  tags   = local.tags
}

resource "aws_route" "default" {
  count                  = length(aws_vpc.default)
  route_table_id         = aws_route_table.default[0].id
  destination_cidr_block = local.internet
  gateway_id             = aws_internet_gateway.default[0].id
}

resource "aws_route_table_association" "default" {
  count          = length(aws_vpc.default)
  subnet_id      = aws_subnet.default[0].id
  route_table_id = aws_route_table.default[0].id
}

resource "aws_key_pair" "default" {
  count      = var.instance_public_key == null ? 0 : 1
  key_name   = var.instance_name
  public_key = var.instance_public_key
  tags       = local.tags
}

data "aws_key_pair" "default" {
  count       = var.instance_aws_key_pair_id == null ? 0 : 1
  key_pair_id = var.instance_aws_key_pair_id
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
  associate_public_ip_address = var.instance_associate_public_ip_address
  instance_type               = var.instance_type
  key_name                    = local.key_name
  subnet_id                   = local.subnet_id
  vpc_security_group_ids      = local.security_group_ids
  tags                        = local.tags
  user_data                   = local.user_data
  root_block_device {
    volume_size = var.instance_root_block_device
  }
}

resource "aws_internet_gateway" "default" {
  count  = length(aws_vpc.default)
  vpc_id = local.vpc_id
  tags   = local.tags
}

resource "aws_ebs_volume" "default" {
  count             = var.instance_volume_size == 0 ? 0 : 1
  availability_zone = local.availability_zone
  size              = var.instance_volume_size
}

resource "aws_volume_attachment" "default" {
  count       = var.instance_volume_size == 0 ? 0 : 1
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.default[0].id
  instance_id = aws_instance.default.id
}
