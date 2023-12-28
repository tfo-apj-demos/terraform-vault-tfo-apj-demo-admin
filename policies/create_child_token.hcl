# Generate child token
path "auth/token/create" {
	capabilities = ["create", "read", "update", "delete", "sudo"]
}

path "auth/token/lookup-accessor" {
  capabilities = ["update"]
}

path "auth/token/revoke-accessor" {
  capabilities = ["update"]
}