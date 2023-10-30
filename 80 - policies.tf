resource "vault_policy" "generate_tfc_token" {
    name = "generate_tfc_token"
    policy =<<EOH
path = "terraform/creds/boundary_admins" {
    capabilities = [
        "create",
        "read",
        "update",
        "delete"
    ]}
EOH
}

resource "vault_policy" "auth_to_oidc" {
    name = "auth_to_oidc"
    policy =<<EOH
path = "identity/oidc/provider/team_se/authorize" {
    capabilities = [ "read" ]
}
EOH
}