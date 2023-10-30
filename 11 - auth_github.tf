resource "vault_github_auth_backend" "this" {
  organization = "hashicorp"
  tune {
    default_lease_ttl = "8h"
    max_lease_ttl = "768h"
    token_type = "default-service"
  }
}