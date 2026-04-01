output "aap_clm_approle_role_id" {
  description = "AppRole Role ID for AAP CLM workflow"
  value       = vault_approle_auth_backend_role.aap_clm.role_id
}

output "aap_clm_approle_secret_id" {
  description = "AppRole Secret ID for AAP CLM workflow"
  value       = vault_approle_auth_backend_role_secret_id.aap_clm.secret_id
  sensitive   = true
}
