locals {
  github_usernames = flatten(
    [ for team in data.github_organization_teams.team_se.teams: team.members if team.name == "team-se" ],
    [ for team in data.github_organization_teams.team_se.teams: team.members if team.name == "team-apac" ]
  )
}

# Lookup our GitHub org for teams and memberships
data "github_organization_teams" "team_se" {
  root_teams_only = true
  summary_only = false
  results_per_page = 10
}

data "github_user" "team_se" {
  for_each = toset(local.github_usernames)
  username = each.value
}

# Create entities and aliases in Vault since the OIDC provider needs an entity
resource "vault_identity_entity_alias" "se" {
  for_each = vault_identity_entity.se
  name = each.value.name
  mount_accessor = vault_github_auth_backend.this.accessor
  canonical_id = each.value.id
}

resource "vault_identity_entity" "se" {
  for_each = toset(local.github_usernames)
  name = each.value
}