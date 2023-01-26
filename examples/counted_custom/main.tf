# Read the prerequisites details.
data "terraform_remote_state" "default" {
  backend = "local"

  config = {
    path = "./prerequisites/terraform.tfstate"
  }
}

module "default" {
  count                          = 2
  source                         = "../../"
  instance_name                  = "counted_custom"
  instance_aws_security_group_rule_tcp_ports = [22, 80, 443]
  instance_aws_key_pair_id       = data.terraform_remote_state.default.outputs.instance_key_pair_id
  instance_aws_vpc_id            = data.terraform_remote_state.default.outputs.instance_vpc_id
  instance_aws_subnet_id         = data.terraform_remote_state.default.outputs.instance_subnet_id
  # instance_aws_security_group_id = data.terraform_remote_state.default.outputs.instance_security_group_id
}

output "default" {
  value = module.default
}
