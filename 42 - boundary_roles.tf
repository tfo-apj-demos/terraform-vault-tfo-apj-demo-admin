resource "boundary_role" "team_se" {
  name          = "team_se"
  principal_ids = [
    boundary_managed_group.team_se.id
  ]
  grant_strings = [
    "id=*;type=*;actions=*"
  ]
  scope_id      = boundary_scope.tfo_apj_demo.id
  grant_scope_id = boundary_scope.tfo_apj_demo.id
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

resource "boundary_role" "u_anon" {
  name = "u_anon"
  principal_ids = [
    "u_anon"
  ]
  grant_strings = [
    "id=*;type=auth-method;actions=list,authenticate",
    "id=*;type=scope;actions=list,no-op",
    "id={{account.id}};actions=read,change-password"
  ]
  scope_id      = "global"
  grant_scope_id = boundary_scope.tfo_apj_demo.id
}

https://8b596635-91df-45a3-8455-1ecbf5e8c43e.boundary.hashicorp.cloud/scopes/o_Kme3VEWJyV/scopes