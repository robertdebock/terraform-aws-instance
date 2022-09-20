output "public_ip" {
  description = "The public IP of the instance."
  value       = aws_instance.default.public_ip
}

output "ssh_connect_string" {
  description = "The command that can be used to login to the instance."
  value       = "ssh -i id_rsa ${local.ssh_user}@${aws_instance.default.public_ip}"
}