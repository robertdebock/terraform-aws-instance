terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.31.0"
    }
    local = {
      source = "hashicorp/local"
      version = "2.2.3"
    }
    tls = {
      source = "hashicorp/tls"
      version = "4.0.3"
    }
  }
}

provider "tls" {
  # Configuration options
}
