# Issuing CA Module - End-entity certificate issuing CAs
# These CAs are signed by the Central Signing CA and issue certificates to applications

locals {
  # Issuing CA configuration
  ca_config = {
    common_name = "GCVE Issuing CA"
    ttl         = "8760h"  # 1 year
    key_type    = "ec"
    key_bits    = 256      # P-256 curve for issuing CAs
  }
  
  # Certificate class configurations with different TTLs
  certificate_classes = {
    server = {
      ttl     = "720h"   # 30 days
      max_ttl = "720h"   # 30 days maximum
      key_usage = ["digital_signature", "key_encipherment"]
      ext_key_usage = ["server_auth"]
      server_flag = true
      client_flag = false
    }
    client = {
      ttl     = "168h"   # 7 days
      max_ttl = "168h"   # 7 days maximum
      key_usage = ["digital_signature", "key_encipherment"]
      ext_key_usage = ["client_auth"]
      server_flag = false
      client_flag = true
    }
    application = {
      ttl     = "48h"    # 2 days
      max_ttl = "48h"    # 2 days maximum
      key_usage = ["digital_signature", "key_encipherment"]
      ext_key_usage = ["server_auth", "client_auth"]
      server_flag = true
      client_flag = true
    }
  }
}

# PKI Secret Engine for Issuing CA
resource "vault_mount" "issuing_ca" {
  path                          = "issuing-ca"
  type                          = "pki"
  description                   = "Issuing CA - Issues end-entity certificates"
  default_lease_ttl_seconds     = 172800    # 48 hours
  max_lease_ttl_seconds         = 2592000   # 30 days
}

# Generate intermediate CA certificate signing request
resource "vault_pki_secret_backend_intermediate_cert_request" "issuing_csr" {
  backend      = vault_mount.issuing_ca.path
  type         = "internal"
  common_name  = local.ca_config.common_name
  
  # Key configuration
  key_type     = local.ca_config.key_type
  key_bits     = local.ca_config.key_bits
  
  # Subject information
  country      = "AU"
  province     = "New South Wales"
  locality     = "Sydney"
  organization = "GCVE"
  ou           = "SEA Division"
  
  # Alternative names
  alt_names = [
    "issuing-ca.hashicorp.local",
    "pki.hashicorp.local"
  ]
}

# Sign the CSR with the Central Signing CA
resource "vault_pki_secret_backend_root_sign_intermediate" "issuing_signed" {
  backend     = var.central_signing_backend_path
  csr         = vault_pki_secret_backend_intermediate_cert_request.issuing_csr.csr
  common_name = local.ca_config.common_name
  
  # Use the central signing CA's role for issuing CAs
  use_csr_values = true
  ttl            = local.ca_config.ttl
}

# Install the signed certificate back into the issuing CA
resource "vault_pki_secret_backend_intermediate_set_signed" "issuing" {
  backend     = vault_mount.issuing_ca.path
  certificate = vault_pki_secret_backend_root_sign_intermediate.issuing_signed.certificate
}

# Configure CA URLs for the issuing CA
resource "vault_pki_secret_backend_config_urls" "issuing_urls" {
  backend                 = vault_mount.issuing_ca.path
  issuing_certificates    = ["https://vault.hashicorp.local/v1/issuing-ca/ca"]
  crl_distribution_points = ["https://vault.hashicorp.local/v1/issuing-ca/crl"]
  
  depends_on = [vault_pki_secret_backend_intermediate_set_signed.issuing]
}

# Create certificate roles for different certificate classes
resource "vault_pki_secret_backend_role" "certificate_roles" {
  for_each = local.certificate_classes
  
  backend     = vault_mount.issuing_ca.path
  name        = "${each.key}-certs"
  
  # Certificate parameters from class configuration
  ttl         = each.value.ttl
  max_ttl     = each.value.max_ttl
  
  # Domain and naming constraints
  allow_any_name      = false
  allow_subdomains    = true
  allowed_domains     = ["*.hashicorp.local"]
  allow_bare_domains  = false
  allow_localhost     = true
  allow_ip_sans       = false
  
  # Key configuration
  key_type            = "ec"
  key_bits            = 256
  key_usage           = each.value.key_usage
  ext_key_usage       = each.value.ext_key_usage
  
  # Certificate flags
  server_flag           = each.value.server_flag
  client_flag           = each.value.client_flag
  code_signing_flag     = false
  email_protection_flag = false
  
  depends_on = [vault_pki_secret_backend_intermediate_set_signed.issuing]
}

# Policy for certificate issuance in this namespace
resource "vault_policy" "issuing_ca_policy" {
  name      = "issuing-ca-access"
  
  policy = <<EOT
# Allow reading CA certificate and CRL
path "${vault_mount.issuing_ca.path}/ca" {
  capabilities = ["read"]
}

path "${vault_mount.issuing_ca.path}/crl" {
  capabilities = ["read"]
}

# Allow issuing certificates for all classes
%{ for class_name, config in local.certificate_classes ~}
path "${vault_mount.issuing_ca.path}/issue/${class_name}-certs" {
  capabilities = ["create", "update"]
}

path "${vault_mount.issuing_ca.path}/roles/${class_name}-certs" {
  capabilities = ["read"]
}
%{ endfor ~}
EOT

  depends_on = [vault_pki_secret_backend_intermediate_set_signed.issuing]
}
