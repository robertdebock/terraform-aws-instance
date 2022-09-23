locals {
  internet = "0.0.0.0/0"

  tags = {
    Name = var.instance_name
  }

  user_data = try(file(var.instance_user_data_script_file), null)

  _aws_ami_name = {
    centos7      = "CentOS 7.*"
    centos8      = "CentOS Stream 8 *"
    centos9      = "CentOS Stream 9 *"
    fedora       = "Fedora-Cloud-Base-36-*"
    oraclelinux7 = "OL7.*"
    oraclelinux8 = "OL8.*"
    oraclelinux9 = "OL9.*"
    ubuntu       = "ubuntu/images/hvm-ssd/ubuntu-focal-*-server-*"
  }
  aws_ami_name = local._aws_ami_name[var.instance_distribution]

  _aws_ami_owner = {
    centos7      = "125523088429"
    centos8      = "125523088429"
    centos9      = "125523088429"
    fedora       = "125523088429"
    oraclelinux7 = "131827586825"
    oraclelinux8 = "131827586825"
    oraclelinux9 = "131827586825"
    ubuntu       = "099720109477"
  }
  aws_ami_owner = local._aws_ami_owner[var.instance_distribution]

  _ssh_user = {
    centos7      = "centos"
    centos8      = "centos"
    centos9      = "centos"
    fedora       = "fedora"
    oraclelinux7 = "ec2-user"
    oraclelinux8 = "ec2-user"
    oraclelinux9 = "ec2-user"
    ubuntu       = "ubuntu"
  }
  ssh_user           = local._ssh_user[var.instance_distribution]
  vpc_id             = coalesce(var.instance_aws_vpc_id, try(aws_vpc.default[0].id, null))
  subnet_id          = try(aws_subnet.default[0].id, data.aws_subnet.default[0].id)
  security_group_ids = [try(aws_security_group.default[0].id, data.aws_security_group.default[0].id)]
  key_name           = try(aws_key_pair.default[0].key_name, data.aws_key_pair.default[0].key_name, null)
}