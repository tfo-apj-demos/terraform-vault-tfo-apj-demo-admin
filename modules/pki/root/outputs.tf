output "backend_path" {
  description = "The mount path of the root CA PKI backend"
  value       = vault_mount.root_ca.path
}

output "ca_certificate" {
  description = "The root CA certificate"
  value       = var.root_ca_cert
}

output "ca_chain" {
  description = "The full CA certificate chain"
  value       = var.root_ca_cert
}

output "signing_role_name" {
  description = "The role name for signing intermediate CAs"
  value       = vault_pki_secret_backend_role.intermediate_ca_signing.name
}

output "issuing_url" {
  description = "The URL for issuing certificates from this CA"
  value       = "https://vault.hashibank.com/v1/${vault_mount.root_ca.path}/ca"
}

output "crl_url" {
  description = "The URL for the certificate revocation list"
  value       = "https://vault.hashibank.com/v1/${vault_mount.root_ca.path}/crl"
}
