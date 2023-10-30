output "oidc_issuer" {
  value = vault_identity_oidc_provider.team_se.issuer
}

output "oidc_client_id" {
  value = vault_identity_oidc_client.boundary.client_id
}

output "oidc_client_secret" {
  value = vault_identity_oidc_client.boundary.client_secret
  sensitive = true
}