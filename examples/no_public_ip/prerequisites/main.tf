resource "tls_private_key" "default" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "default" {
  key_name   = "my-no-public-pip-key"
  public_key = tls_private_key.default.public_key_openssh
}

resource "local_file" "private" {
  filename = "id_rsa"
  content  = tls_private_key.default.private_key_openssh
}
