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
    boundary = {
      source  = "hashicorp/boundary"
      version = "~> 1"
    }
  }
}

provider "boundary" {
  addr                   = var.boundary_addr
}

provider "vault" {
  namespace = "admin/tfo-apj-demos"
  # Configuration options
}

provider "github" {}
provider "tfe" {
  organization = "tfo-apj-demos"
}