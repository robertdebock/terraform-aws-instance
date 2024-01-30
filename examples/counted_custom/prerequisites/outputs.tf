output "instance_vpc_id" {
  value = aws_vpc.default.id
}

output "instance_subnet_id" {
  value = aws_subnet.default.id
}

output "instance_security_group_id" {
  value = aws_security_group.default.id
}

output "instance_key_pair_id" {
  value = aws_key_pair.default.key_pair_id
}