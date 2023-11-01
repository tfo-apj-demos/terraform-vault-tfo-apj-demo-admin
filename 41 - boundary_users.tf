resource "boundary_account_oidc" "this" {
  for_each = vault_identity_entity.se
  description = "Populated from Github Account"
  auth_method_id = boundary_auth_method_oidc.this.id
  name = each.value.name 
  subject = each.value.id
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