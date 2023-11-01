resource "vault_policy" "generate_tfc_token" {
    name = "generate_tfc_token"
    policy =<<EOH
path "terraform/creds/boundary_admins" {
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
path "${vault_identity_oidc_provider.team_se.id}" {
    capabilities = [ "read" ]
}
EOH
}