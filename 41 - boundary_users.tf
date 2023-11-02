resource "boundary_managed_group" "team_se" {
  name           = "team_se"
  auth_method_id = boundary_auth_method_oidc.team_se.id
  filter         = "name == \"team-se\""
}

resource "boundary_account_oidc" "this" {
  for_each = vault_identity_entity.se
  description = "Populated from Github Account"
  auth_method_id = boundary_auth_method_oidc.team_se.id
  name = each.value.name 
  subject = each.value.id
  issuer = "https://production.vault.11eb56d6-0f95-3a99-a33c-0242ac110007.aws.hashicorp.cloud:8200/v1/admin/tfo-apj-demos/identity/oidc/provider/team_se"
}


resource "boundary_user" "this" {
  for_each = boundary_account_oidc.this
  name        = each.value.name
  description = "Populated from Github Account"
  account_ids = [
    each.value.id
  ]
  scope_id    = boundary_scope.tfo_apj_demo.id
}