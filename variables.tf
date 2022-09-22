variable "instance_name" {
  default     = "unset"
  description = "The name of the deployment"
  type        = string
  validation {
    condition     = length(var.instance_name) <= 16 && length(var.instance_name) >= 4 && var.instance_name != "default"
    error_message = "Please use a name between 4 and 16 characters, not \"default\"."
  }
}

variable "instance_aws_vpc_cidr_block" {
  default     = "10.0.0.0/16"
  description = "The CIDR block to use for the VPC."
  type        = string
}

variable "instance_aws_security_group_rule_tcp_ports" {
  default     = [22]
  description = "TPC ports to allow access to from the internet."
  type        = list(number)
}


variable "instance_aws_security_group_rule_udp_ports" {
  default     = []
  description = "UDP ports to allow access to from the internet."
  type        = list(number)
}

variable "instance_user_data_script_file" {
  default     = null
  description = "An (optional) script to execute on the deployed instance."
  type        = string
  validation {
    condition     = var.instance_user_data_script_file == null || try(fileexists(var.instance_user_data_script_file), true)
    error_message = "The file does not exist."
  }
}

variable "instance_distribution" {
  default     = "fedora"
  description = "Pick the distribution you would like to use."
  type        = string
  validation {
    condition     = contains(["centos7", "centos8", "centos9", "fedora", "oraclelinux7", "oraclelinux8", "oraclelinux9", "ubuntu"], var.instance_distribution)
    error_message = "Please choose from \"centos(7|8|9)\", \"fedora\", \"oraclelinux(7|8|9)\", or \"ubuntu\"."
  }
}

variable "instance_type" {
  default     = "t3.micro"
  description = "The type of instance to deploy."
  type        = string
}

variable "instance_aws_vpc_id" {
  default     = null
  description = "Optionally specify the (existing) VPC to deploy in. Not setting this value, means this module will create a VPC."
  type        = string
  validation {
    condition     = var.instance_aws_vpc_id == null || can(regex("^vpc-.*", var.instance_aws_vpc_id))
    error_message = "Please set a VPC starting with \"vpc-\"."
  }
}

variable "instance_aws_subnet_id" {
  default     = null
  description = "Optionally specify the (existing) subnet to deploy in. Not setting this value, means this module will create a subnet."
  type        = string
  validation {
    condition     = var.instance_aws_subnet_id == null || can(regex("^subnet-.*", var.instance_aws_subnet_id))
    error_message = "Please set a subnet starting with \"subnet-\"."
  }
}


variable "instance_aws_security_group_id" {
  default     = null
  description = "Optionally specify the (existing) security group to deploy in. Not setting this value, means this module will create a security group."
  type        = string
  validation {
    condition     = var.instance_aws_security_group_id == null || can(regex("^sg-.*", var.instance_aws_security_group_id))
    error_message = "Please set a subnet starting with \"sg-\"."
  }
}

variable "instance_aws_key_pair_id" {
  default     = null
  description = "Optionally specify the (existing) ssh key pair to use. Not setting this value, means this module will place a key pair."
  type        = string
  validation {
    condition     = var.instance_aws_key_pair_id == null || can(regex("^key-.*", var.instance_aws_key_pair_id))
    error_message = "Please set a subnet starting with \"key-\"."
  }
}

variable "instance_public_key" {
  default     = null
  description = "Optionally specify the contents of an (existing) rsa ssh public key to use."
  type        = string
  validation {
    condition     = var.instance_public_key == null || can(regex("^ssh-rsa .*", var.instance_public_key))
    error_message = "Please provide the contents of an rsa public ssh key."
  }
}
