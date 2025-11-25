output "backend_path" {
  description = "The mount path of the issuing CA PKI backend"
  value       = vault_mount.issuing_ca.path
}

output "ca_certificate" {
  description = "The issuing CA certificate"
  value       = vault_pki_secret_backend_intermediate_set_signed.issuing.certificate
}

output "ca_chain" {
  description = "The full CA certificate chain"
  value       = vault_pki_secret_backend_intermediate_set_signed.issuing.certificate
}

output "certificate_roles" {
  description = "Map of certificate roles and their configurations"
  value = {
    for class_name, config in local.certificate_classes : class_name => {
      role_name = "${class_name}-certs"
      ttl       = config.ttl
      max_ttl   = config.max_ttl
      usage     = config.ext_key_usage
    }
  }
}

output "issuing_endpoints" {
  description = "Certificate issuing endpoints for each certificate class"
  value = {
    for class_name, config in local.certificate_classes : class_name => 
      "https://vault.hashibank.com/v1/issuing-ca/issue/${class_name}-certs"
  }
}

output "issuing_url" {
  description = "The URL for reading the issuing CA certificate"
  value       = "https://vault.hashibank.com/v1/issuing-ca/ca"
}

output "crl_url" {
  description = "The URL for the certificate revocation list"
  value       = "https://vault.hashibank.com/v1/issuing-ca/crl"
}
