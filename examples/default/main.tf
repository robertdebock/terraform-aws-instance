module "instance" {
  source = "../../"
}

output "all" {
  value = module.instance
}