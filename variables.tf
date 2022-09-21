variable "instance_name" {
  default     = "unset"
  description = "The name of the deployment"
  type        = string
  validation {
    condition = length(var.instance_name) <= 16 && length(var.instance_name) >= 4 && var.instance_name != "default"
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