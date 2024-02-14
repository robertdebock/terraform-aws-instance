# Terraform AWS Instane

A module to spin up an instance on AWS with the minimal amount of variable.

## Variables


| Variable                                     | Default       | Type           | Description                 |
| -------------------------------------------- | ------------- | -------------- | --------------------------- |
| `instance_name`                              | `unset`       | `string`       | The name of the deployment. |
| `instance_aws_vpc_cidr_block`                | `10.0.0.0/16` | `string`       | The CIDR block to use for the VPC. |
| `instance_aws_security_group_rule_tcp_ports` | `[22]`        | `list(number)` | TPC ports to allow access to from the internet. |
| `instance_aws_security_group_rule_udp_ports` | `[]`          | `list(number)` | UDP ports to allow access to from the internet. |
| `instance_user_data_script_file`             | `null`        | `string`       | An (optional) script to execute on the deployed instance. |
| `instance_distribution`                      | `fedora`      | `string`       | Pick the distribution you would like to use. Any of "centos7", "centos8", "centos9", "fedora", "oraclelinux7", "oraclelinux8", "oraclelinux9", or "ubuntu". |
| `instance_type`                              | `t3.micro`    | `string`       | The type of instance to deploy. |
| `instance_aws_vpc_id`                        | `null`        | `string`       | Optionally specify the (existing) VPC to deploy in. Not setting this value, means this module will create a VPC. |
| `instance_aws_subnet_id`                     | `null`        | `string`       | Optionally specify the (existing) subnet to deploy in. Not setting this value, means this module will create a subnet. |
| `instance_aws_security_group_id`             | `null`        | `string`       | Optionally specify the (existing) security group to deploy in. Not setting this value, means this module will create a security group. |
| `instance_aws_key_pair_id`                   | `null`        | `string`       | Optionally specify the (existing) ssh key pair to use. Not setting this value, means this module will place a key pair. |
| `instance_public_key`                        | `null`        | `string`       | Optionally specify the contents of an (existing) rsa ssh public key to use. |
| `instance_volume_size`                       | `0`           | `number`       | The size in gigabytes of the extra volume attached to the instance. "0" means no volume will be added. |
| `instance_associate_public_ip_address`       | `true`        | `bool`         | Whether to associate a public IP address with this instance. |
| `instance_root_block_device`                 | `16`          | `number`       | The size in gigabytes of the primary disk. |
