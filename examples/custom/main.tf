module "instance" {
  source                                     = "../../"
  instance_distribution                      = "ubuntu"
  instance_name                              = "my_instance" 
  instance_aws_security_group_rule_tcp_ports = [22, 80, 443]
  instance_user_data_script_file             = "myscript.sh"
}

output "all" {
  value = module.instance
}