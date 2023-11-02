resource "boundary_scope" "tfo_apj_demo" {
  name     = "tfo_apj_demo"
  scope_id = "global"
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
  api_url_prefix = "https://8b596635-91df-45a3-8455-1ecbf5e8c43e.boundary.hashicorp.cloud"
  claims_scopes = [
    "groups",
    "user"
  ]
  name = "vault"
  state = "active-public"
  is_primary_for_scope = true
}