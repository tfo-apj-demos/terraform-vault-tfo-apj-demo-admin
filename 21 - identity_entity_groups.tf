# Create external groups and associate them with Github aliases
resource "vault_identity_group" "team_se" {
  name     = "team-se"
  type     = "internal"
  policies = [
    "default",
    vault_policy.auth_to_oidc.name
  ]
  member_entity_ids = [ 
    for v in vault_identity_entity.se: v.id
  ]
}

resource "vault_identity_group" "gcve_admins" {
  name = "gcve-admins"
  type = "internal"
  policies = []
  member_entity_ids = [ 
    for v in var.gcve_admin_github_alisases: vault_identity_entity.se[v]
  ]
}