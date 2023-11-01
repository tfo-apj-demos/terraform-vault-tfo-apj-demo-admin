# Create external groups and associate them with Github aliases
resource "vault_identity_group" "team_se" {
  name     = "team-se"
  type     = "external"
  policies = [
    "default",
    vault_policy.auth_to_oidc.name
  ]
}

resource "vault_identity_group_alias" "team_se" {
  name           = "team-se"
  mount_accessor = vault_github_auth_backend.this.accessor
  canonical_id   = vault_identity_group.team_se.id
}

resource "vault_identity_group" "apac_se" {
  name     = "apac-se"
  type     = "external"
  policies = [
    "default",
    vault_policy.auth_to_oidc.name
  ]
}

resource "vault_identity_group_alias" "apac_se" {
  name           = "apac-se"
  mount_accessor = vault_github_auth_backend.this.accessor
  canonical_id   = vault_identity_group.team_se.id
}