# ============================================================================
# Multi-PKI Engine Management Policy
# Manages: pki, root-ca, central-signing-ca, issuing-ca
# ============================================================================

# PKI Engine: pki
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

# Allow certificate issuance
path "pki/issue/*" {
    capabilities = ["create", "update"]
}

# Allow certificate signing
path "pki/sign/*" {
    capabilities = ["create", "update"]
}

# Allow certificate revocation
path "pki/revoke" {
    capabilities = ["update"]
}

# Allow CRL operations
path "pki/crl/rotate" {
    capabilities = ["update"]
}

# Allow listing certificates
path "pki/certs" {
    capabilities = ["list"]
}

# Allow reading specific certificates
path "pki/cert/*" {
    capabilities = ["read"]
}

# ============================================================================
# PKI Engine: root-ca
# ============================================================================

path "root-ca/issuers/generate/intermediate/*" {
    capabilities = ["create", "update"]
}

path "root-ca/intermediate/set-signed" {
    capabilities = ["update"]
}

path "root-ca/root/sign-intermediate" {
    capabilities = ["create", "update"]
}

path "root-ca/issuers/*" {
    capabilities = ["read", "list"]
}

path "root-ca/config/urls" {
    capabilities = ["create", "update", "read"]
}

path "root-ca/roles/*" {
    capabilities = ["create", "update", "read", "delete", "list"]
}

path "root-ca/ca" {
    capabilities = ["read"]
}

path "root-ca/ca_chain" {
    capabilities = ["read"]
}

path "root-ca/issue/*" {
    capabilities = ["create", "update"]
}

path "root-ca/sign/*" {
    capabilities = ["create", "update"]
}

path "root-ca/revoke" {
    capabilities = ["update"]
}

path "root-ca/crl/rotate" {
    capabilities = ["update"]
}

path "root-ca/certs" {
    capabilities = ["list"]
}

path "root-ca/cert/*" {
    capabilities = ["read"]
}

# ============================================================================
# PKI Engine: central-signing-ca
# ============================================================================

path "central-signing-ca/issuers/generate/intermediate/*" {
    capabilities = ["create", "update"]
}

path "central-signing-ca/intermediate/set-signed" {
    capabilities = ["update"]
}

path "central-signing-ca/root/sign-intermediate" {
    capabilities = ["create", "update"]
}

path "central-signing-ca/issuers/*" {
    capabilities = ["read", "list"]
}

path "central-signing-ca/config/urls" {
    capabilities = ["create", "update", "read"]
}

path "central-signing-ca/roles/*" {
    capabilities = ["create", "update", "read", "delete", "list"]
}

path "central-signing-ca/ca" {
    capabilities = ["read"]
}

path "central-signing-ca/ca_chain" {
    capabilities = ["read"]
}

path "central-signing-ca/issue/*" {
    capabilities = ["create", "update"]
}

path "central-signing-ca/sign/*" {
    capabilities = ["create", "update"]
}

path "central-signing-ca/revoke" {
    capabilities = ["update"]
}

path "central-signing-ca/crl/rotate" {
    capabilities = ["update"]
}

path "central-signing-ca/certs" {
    capabilities = ["list"]
}

path "central-signing-ca/cert/*" {
    capabilities = ["read"]
}

# ============================================================================
# PKI Engine: issuing-ca
# ============================================================================

path "issuing-ca/issuers/generate/intermediate/*" {
    capabilities = ["create", "update"]
}

path "issuing-ca/intermediate/set-signed" {
    capabilities = ["update"]
}

path "issuing-ca/root/sign-intermediate" {
    capabilities = ["create", "update"]
}

path "issuing-ca/issuers/*" {
    capabilities = ["read", "list"]
}

path "issuing-ca/config/urls" {
    capabilities = ["create", "update", "read"]
}

path "issuing-ca/roles/*" {
    capabilities = ["create", "update", "read", "delete", "list"]
}

path "issuing-ca/ca" {
    capabilities = ["read"]
}

path "issuing-ca/ca_chain" {
    capabilities = ["read"]
}

path "issuing-ca/issue/*" {
    capabilities = ["create", "update"]
}

path "issuing-ca/sign/*" {
    capabilities = ["create", "update"]
}

path "issuing-ca/revoke" {
    capabilities = ["update"]
}

path "issuing-ca/crl/rotate" {
    capabilities = ["update"]
}

path "issuing-ca/certs" {
    capabilities = ["list"]
}

path "issuing-ca/cert/*" {
    capabilities = ["read"]
}