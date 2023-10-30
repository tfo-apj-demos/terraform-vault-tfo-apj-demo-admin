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
    tfe = {
      source = "hashicorp/tfe"
      version = "~> 0"
    }
  }
}

provider "vault" {
  namespace = "admin/tfo-apj-demos"
  # Configuration options
}

provider "github" {}
provider "tfe" {
  organization = "tfo-apj-demos"
}