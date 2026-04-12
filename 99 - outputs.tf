output "aap_clm_approle_role_id" {
  description = "AppRole Role ID for AAP CLM workflow"
  value       = vault_approle_auth_backend_role.aap_clm.role_id
}

output "aap_clm_approle_secret_id" {
  description = "AppRole Secret ID for AAP CLM workflow"
  value       = vault_approle_auth_backend_role_secret_id.aap_clm.secret_id
  sensitive   = true
}

output "openshift_oidc_client_id" {
  description = "OIDC Client ID for OpenShift OAuth"
  value       = vault_identity_oidc_client.openshift.client_id
}

output "openshift_oidc_client_secret" {
  description = "OIDC Client Secret for OpenShift OAuth"
  value       = vault_identity_oidc_client.openshift.client_secret
  sensitive   = true
}
