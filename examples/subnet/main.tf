# Read the prerequisites details.
data "terraform_remote_state" "default" {
  backend = "local"

  config = {
    path = "./prerequisites/terraform.tfstate"
  }
}

module "instance" {
  source                          = "../../"
  instance_user_data_script_file  = "myscript.sh"
  instance_aws_subnet_id          = data.terraform_remote_state.default.outputs.instance_subnet_id
}

output "all" {
  value = module.instance
}
