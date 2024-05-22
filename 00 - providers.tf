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
  cloud {
    organization = "tfo-apj-demos"
    workspaces {
      name = "vault-hcp-config"
    }
  }
}

provider "boundary" {
  addr                   = var.boundary_address
  auth_method_id         = var.service_account_authmethod_id
  auth_method_login_name = var.service_account_name
  auth_method_password   = var.service_account_password
}

provider "vault" {
  namespace = "admin/tfo-apj-demos"
}

provider "github" {}
provider "tfe" {
  organization = "tfo-apj-demos"
}