module "instance" {
  source                = "../../"
  instance_distribution = "centos7"
}

output "all" {
  value = module.instance
}
