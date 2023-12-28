locals {
  github_usernames = toset(data.tfe_outputs.github_identities.values.github_usernames)
}

data "tfe_outputs" "github_identities" {
  organization = var.tfc_organization
  workspace = var.tfc_workspace
}

# Create entities and aliases in Vault since the OIDC provider needs an entity
resource "vault_identity_entity_alias" "se" {
  for_each = vault_identity_entity.se
  name = each.value.name
  mount_accessor = vault_github_auth_backend.this.accessor
  canonical_id = each.value.id
}

resource "vault_identity_entity" "se" {
  for_each = nonsensitive(local.github_usernames)
  name = each.value
}