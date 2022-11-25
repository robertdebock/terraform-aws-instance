# Read the prerequisites details.
data "terraform_remote_state" "default" {
  backend = "local"

  config = {
    path = "./prerequisites/terraform.tfstate"
  }
}

module "instance" {
  source                          = "../../"
  instance_aws_key_pair_id        = data.terraform_remote_state.default.outputs.instance_key_pair_id
  instance_user_data_script_file  = "myscript.sh"
  instance_volume_size            = 16
}

output "all" {
  value = module.instance
}
