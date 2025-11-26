# Token Lookup Policy
# Allows tokens to look up their own information and perform basic token operations

# Allow token to look up its own information
path "auth/token/lookup-self" {
  capabilities = ["read"]
}

# Allow token to lookup other tokens by accessor (useful for debugging)
path "auth/token/lookup-accessor" {
  capabilities = ["update"]
}

# Allow token to lookup tokens by token value (admin function)
path "auth/token/lookup" {
  capabilities = ["update"]
}

# Allow token to renew itself
path "auth/token/renew-self" {
  capabilities = ["update"]
}

# Allow token to revoke itself (cleanup)
path "auth/token/revoke-self" {
  capabilities = ["update"]
}

# Allow reading token capabilities for debugging
path "sys/capabilities-self" {
  capabilities = ["update"]
}

# Allow checking token accessor information
path "auth/token/lookup-accessor/*" {
  capabilities = ["update"]
}