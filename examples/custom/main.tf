module "centos7" {
  source                                     = "../../"
  instance_distribution                      = "centos7"
  instance_name                              = "centos7" 
  instance_aws_security_group_rule_tcp_ports = [22, 80, 443]
  instance_user_data_script_file             = "myscript.sh"
}

module "centos8" {
  source                                     = "../../"
  instance_distribution                      = "centos8"
  instance_name                              = "centos8" 
  instance_aws_security_group_rule_tcp_ports = [22, 80, 443]
  instance_user_data_script_file             = "myscript.sh"
}

module "centos9" {
  source                                     = "../../"
  instance_distribution                      = "centos9"
  instance_name                              = "centos9" 
  instance_aws_security_group_rule_tcp_ports = [22, 80, 443]
  instance_user_data_script_file             = "myscript.sh"
}

module "fedora" {
  source                                     = "../../"
  instance_distribution                      = "fedora"
  instance_name                              = "fedora" 
  instance_aws_security_group_rule_tcp_ports = [22, 80, 443]
  instance_user_data_script_file             = "myscript.sh"
}

module "oraclelinux7" {
  source                                     = "../../"
  instance_distribution                      = "oraclelinux7"
  instance_name                              = "oraclelinux7" 
  instance_aws_security_group_rule_tcp_ports = [22, 80, 443]
  instance_user_data_script_file             = "myscript.sh"
}

module "oraclelinux8" {
  source                                     = "../../"
  instance_distribution                      = "oraclelinux8"
  instance_name                              = "oraclelinux8" 
  instance_aws_security_group_rule_tcp_ports = [22, 80, 443]
  instance_user_data_script_file             = "myscript.sh"
}

module "oraclelinux9" {
  source                                     = "../../"
  instance_distribution                      = "oraclelinux9"
  instance_name                              = "oraclelinux9" 
  instance_aws_security_group_rule_tcp_ports = [22, 80, 443]
  instance_user_data_script_file             = "myscript.sh"
}

module "ubuntu" {
  source                                     = "../../"
  instance_distribution                      = "ubuntu"
  instance_name                              = "ubuntu" 
  instance_aws_security_group_rule_tcp_ports = [22, 80, 443]
  instance_user_data_script_file             = "myscript.sh"
}
output "centos7" {
  value = module.centos7
}

output "centos8" {
  value = module.centos8
}

output "centos9" {
  value = module.centos9
}

output "oraclelinux7" {
  value = module.oraclelinux7
}

output "oraclelinux8" {
  value = module.oraclelinux8
}

output "oraclelinux9" {
  value = module.oraclelinux9
}

output "fedora" {
  value = module.fedora
}

output "ubuntu" {
  value = module.ubuntu
}