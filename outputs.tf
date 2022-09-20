output "public_ip" {
  value = aws_instance.default.public_ip
}

output "ssh_connect_string" {
  value = "ssh -i id_rsa ${local.ssh_user}@${aws_instance.default.public_ip}"
}