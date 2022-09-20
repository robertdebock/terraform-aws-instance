locals {
  internet = "0.0.0.0/0"
  
  tags = {
    Name = var.instance_name
  }
  
  user_data = try(file(var.instance_user_data_script_file), null)

  _aws_ami_name = {
    fedora = "Fedora-Cloud-Base-36-*"
    ubuntu = "ubuntu/images/hvm-ssd/ubuntu-focal-*-server-*"
  }
  aws_ami_name = local._aws_ami_name[var.instance_distribution]

  _aws_ami_owner = {
    fedora = "125523088429"
    ubuntu = "099720109477"
  }
  aws_ami_owner = local._aws_ami_owner[var.instance_distribution]

  _ssh_user = {
    fedora = "fedora"
    ubuntu = "ubuntu"
  }
  ssh_user = local._ssh_user[var.instance_distribution]
}