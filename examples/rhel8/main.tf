module "instance" {
  source                = "../../"
  instance_distribution = "rhel8"
}

output "all" {
  value = module.instance
}
