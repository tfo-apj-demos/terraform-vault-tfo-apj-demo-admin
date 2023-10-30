resource "vault_github_auth_backend" "this" {
  organization = "hashicorp"
  tune {
    default_lease_ttl = "8h"
    max_lease_ttl = "768h"
    token_type = "default-service"
  }
}

resource "vault_identity_group" "team_se" {
  name     = "team-se"
  type     = "external"
  policies = [
    "default",
    "oidc"
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
    "oidc"
  ]
}

resource "vault_identity_group_alias" "apac_se" {
  name           = "apac-se"
  mount_accessor = vault_github_auth_backend.this.accessor
  canonical_id   = vault_identity_group.team_se.id
}


