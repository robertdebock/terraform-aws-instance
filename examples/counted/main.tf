module "instance" {
  count  = 2
  source = "../../"
}

output "all" {
  value = module.instance
}
