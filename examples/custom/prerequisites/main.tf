module "centos7" {
  source                                     = "../../../"
  instance_distribution                      = "centos7"
  instance_name                              = "centos7"
  instance_aws_security_group_rule_tcp_ports = [22, 80, 443]
  instance_user_data_script_file             = "myscript.sh"
}
