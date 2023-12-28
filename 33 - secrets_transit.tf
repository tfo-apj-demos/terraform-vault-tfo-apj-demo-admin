import {
  resource = "transit"
  to = vault_mount.transit
}

resource "vault_mount" "transit" {
  path                      = "transit"
  type                      = "transit"
  default_lease_ttl_seconds = 3600
  max_lease_ttl_seconds     = 86400
}

import {
  resource = "transit/vault_unseal"
  to = vault_transit_secret_backend_key.vault_unseal
}

resource "vault_transit_secret_backend_key" "vault_unseal" {
  backend = vault_mount.transit.path
  name    = "vault_unseal"
}