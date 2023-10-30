resource "vault_policy" "generate_tfc_token" {
    name = "generate_tfc_token"
    path = vault_terraform_cloud_secret_role.boundary_admins.path
    capabilities = [
        "create",
        "read",
        "update",
        "delete"
    ]
}

resource "vault_policy" "auth_to_oidc" {
    name = "auth_to_oidc"
    path = "identity/oidc/provider/team_se/authorize"
    capabilities = [ "read" ] 
}