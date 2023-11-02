resource "boundary_scope" "project" {
  name     = var.scope_name
  scope_id = var.parent_scope_id
}

resource "vault_token" "this" {
  period = 7200
  renewable = true
  no_parent = true
  policies = [
    "default",
    "sign_ssh_certificate"
  ]
}

resource "boundary_credential_store_vault" "this" {
  name        = "HCP Vault"
  address     = var.vault_address
  token       = vault_token.this.client_token
  namespace   = "admin/tfo-apj-demos"
  scope_id    = boundary_scope.project.id
}

resource "boundary_credential_library_vault_ssh_certificate" "this" {
  name = "SSH Key Signing"
  path = "ssh/sign/boundary"
  username = "ubuntu"
  key_type            = "ed25519"
  credential_store_id = boundary_credential_store_vault.this.id
}

