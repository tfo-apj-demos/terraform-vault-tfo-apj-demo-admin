path "pki/issue/gcve" {
  capabilities = ["create", "read", "update"]
}

path "issuing-ca/issue/server-certs" {
  capabilities = ["create", "read", "update"]
}

path "issuing-ca/revoke" {
  capabilities = ["create", "update"]
}

path "issuing-ca/tidy" {
  capabilities = ["create", "update"]
}