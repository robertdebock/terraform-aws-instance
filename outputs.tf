output "instance_public_ip" {
  description = "The public IP of the instance."
  value       = aws_instance.default.public_ip
}

output "instance_ssh_username" {
  description = "The username required to login."
  value       = local.ssh_user
}

output "instance_ssh_connect_string" {
  description = "The command that can be used to login to the instance."
  value       = "ssh ${local.ssh_user}@${aws_instance.default.public_ip}"
}

output "instance_private_ip" {
  description = "The private IP address of the instance."
  value       = aws_instance.default.private_ip
}

output "instance_vpc_id" {
  description = "The VPC id where the instance is deployed."
  value       = var.instance_aws_vpc_id == null ? try(aws_vpc.default[0].id, "Nothing") : var.instance_aws_vpc_id
}

output "instance_subnet_id" {
  description = "The subnet id where the instance is deployed."
  value       = var.instance_aws_subnet_id == null ? try(aws_subnet.default[0].id, "Nothing") : var.instance_aws_subnet_id
}

output "instance_security_group_id" {
  description = "The security group where the instance is deployed."
  value       = var.instance_aws_security_group_id == null ? try(aws_security_group.default[0].id, "Nothing") : var.instance_aws_security_group_id
}
