resource "vault_terraform_cloud_secret_backend" "this" {
  token       = var.tfc_token
}

data "tfe_team" "boundary_admins" {
  organization = var.tfc_org_name
  name = "boundary_admins"
}

resource "vault_terraform_cloud_secret_role" "boundary_admins" {
  backend      = vault_terraform_cloud_secret_backend.this.backend
  name         = "boundary_admins"
  organization = var.tfc_org_name
  team_id      = data.tfe_team.boundary_admins.id
}