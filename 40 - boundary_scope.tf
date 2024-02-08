# Create org scope and auth method

resource "boundary_scope" "tfo_apj_demo" {
  name     = "tfo_apj_demos"
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

# --- Create a project for each SE
module "projects" {
  source = "./modules/project_bootstrap"
  for_each = boundary_user.this

  scope_name = each.value.name
  parent_scope_id = boundary_scope.tfo_apj_demo.id
  vault_address = "https://production.vault.11eb56d6-0f95-3a99-a33c-0242ac110007.aws.hashicorp.cloud:8200"
  project_admin_principal_ids = [
    each.value.id,
    "g_m1JZt2HHra", # boundary_admins group. Data source would be helpful here.
    "mgoidc_9ujagjtUP1"
  ]
}

# --- Create a project for shared access

# --- Create a project for admin access
module "admin_project" {
  source = "./modules/project_bootstrap"

  scope_name = "gcve_admins"
  parent_scope_id = boundary_scope.tfo_apj_demo.id
  project_admin_principal_ids = [
    "g_m1JZt2HHra",
    "mgoidc_9ujagjtUP1"
  ]
  vault_address = "https://production.vault.11eb56d6-0f95-3a99-a33c-0242ac110007.aws.hashicorp.cloud:8200"
}