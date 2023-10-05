terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.19.0"
    }
    local = {
      source = "hashicorp/local"
      version = "2.4.0"
    }
    tls = {
      source = "hashicorp/tls"
      version = "4.0.4"
    }
  }
}

provider "tls" {
  # Configuration options
}
