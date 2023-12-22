
# resource "vault_policy" "generate_tfc_token" {
#     name = "generate_tfc_token"
#     policy =<<EOH
# path "terraform/creds/boundary_admins" {
#     capabilities = [
#         "create",
#         "read",
#         "update",
#         "delete"
#     ]}
# EOH
# }

resource "vault_policy" "this" {
    for_each = fileset("${path.module}/policies", "*.hcl")
    name = trimsuffix(each.value, ".hcl")
    policy = file("${path.module}/policies/${each.value}")
}   

# resource "vault_policy" "auth_to_oidc" {
#     name = "auth_to_oidc"
#     policy =<<EOH
# path "identity/oidc/provider/team_se/authorize" {
#     capabilities = [ "read" ]
# }
# EOH
# }

# resource "vault_policy" "ssh_sign" {
#     name = "sign_ssh_certificate"
#     policy =<<EOH
# path "ssh/sign/boundary" {
#   capabilities = ["read", "update"]
# }
# EOH
# }

# resource "vault_policy" "revoke_lease" {
#     name = "revoke_lease"
#     policy =<<EOH
# path "sys/leases/revoke" {
#     capabilities = ["update"]
# }
# EOH
# }

# resource "vault_policy" "manage_pki" {
#     name = "manage_pki"
#     policy =<<EOH
# path "pki/intermediate/set-signed" {
#     capabilities = ["update"]
# }
# }