# Read the prerequisites details.
data "terraform_remote_state" "default" {
  backend = "local"

  config = {
    path = "./prerequisites/terraform.tfstate"
  }
}

module "instance" {
  source                               = "../../"
  instance_associate_public_ip_address = false
  instance_aws_key_pair_id             = data.terraform_remote_state.default.outputs.instance_key_pair_id
}

output "all" {
  value = module.instance
}
