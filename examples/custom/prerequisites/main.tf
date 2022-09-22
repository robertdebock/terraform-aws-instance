resource "tls_private_key" "default" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "default" {
  key_name   = "centos7"
  public_key = tls_private_key.default.public_key_openssh
}

resource "local_file" "default" {
  filename = "id_rsa"
  content  = tls_private_key.default.private_key_openssh
}

module "centos7" {
  source                                     = "../../../"
  instance_distribution                      = "centos7"
  instance_name                              = "centos7"
  instance_aws_security_group_rule_tcp_ports = [22, 80, 443]
  instance_user_data_script_file             = "myscript.sh"
}
