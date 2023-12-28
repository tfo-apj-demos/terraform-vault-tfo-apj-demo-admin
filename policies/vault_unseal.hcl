path "transit/encrypt/vault_unseal" {
   capabilities = [ "update" ]
}

path "transit/decrypt/vault_unseal" {
   capabilities = [ "update" ]
}

path "transit/keys/vault_unseal" {
   capabilities = ["read"]
}

path "transit" {
   capabilities = ["read","update"]
}