resource "boundary_scope" "tfo_apj_demo" {
  name     = "tfo_apj_demo"
  scope_id = "global"
}

resource "boundary_role" "this" {
  name          = "scope_admin"
  principal_ids = [
    "g_m1JZt2HHra" # boundary_admins group. Data source would be helpful here.
  ]
  grant_strings = [
    "id=*;type=*;actions=*"
  ]
  scope_id      = "global"
  grant_scope_id = boundary_scope.tfo_apj_demo.id
}

resource "boundary_auth_method_oidc" "team_se" {
  depends_on = [
    boundary_role.this
  ]
  scope_id = boundary_scope.tfo_apj_demo.id
  issuer = vault_identity_oidc_provider.team_se.issuer
  client_id = vault_identity_oidc_client.boundary.client_id
  client_secret = vault_identity_oidc_client.boundary.client_secret
  signing_algorithms = ["RS256"]
  api_url_prefix = "https://e0078f32-6a05-44fe-a147-158f9d15a5fb.boundary.hashicorp.cloud"
  claims_scopes = [
    "groups",
    "user"
  ]
  name = "vault"
  state = "active-public"
  is_primary_for_scope = true
}

resource "boundary_managed_group" "team_se" {
  name           = "team_se"
  auth_method_id = boundary_auth_method_oidc.team_se.id
  filter         = "name == \"team_se\" or name == \"apac_se\""
}