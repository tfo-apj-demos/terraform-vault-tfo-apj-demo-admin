terraform {
  required_providers {
    vault = {
      source = "hashicorp/vault"
      version = "~> 3"
    }
    github = {
      source = "integrations/github"
      version = "~> 5"
    }
  }
}

provider "vault" {
  namespace = "admin/tfo-apj-demos"
  # Configuration options
}