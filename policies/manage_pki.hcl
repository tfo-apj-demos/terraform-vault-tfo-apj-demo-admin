# Allow generating intermediate CA CSR
path "pki/issuers/generate/intermediate/*" {
    capabilities = ["create", "update"]
}

# Allow setting the signed intermediate certificate
path "pki/intermediate/set-signed" {
    capabilities = ["update"]
}

# Allow signing intermediate certificates with the root CA
path "pki/root/sign-intermediate" {
    capabilities = ["create", "update"]
}

# Allow reading issuer information
path "pki/issuers/*" {
    capabilities = ["read", "list"]
}

# Allow configuring URLs
path "pki/config/urls" {
    capabilities = ["create", "update", "read"]
}

# Allow managing roles
path "pki/roles/*" {
    capabilities = ["create", "update", "read", "delete", "list"]
}

# Allow reading the CA certificate
path "pki/ca" {
    capabilities = ["read"]
}

# Allow reading the CA chain
path "pki/ca_chain" {
    capabilities = ["read"]
}