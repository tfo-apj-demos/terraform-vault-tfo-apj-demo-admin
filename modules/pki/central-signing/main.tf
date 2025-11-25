# Central Signing CA Module - Intermediate CA
# This CA is signed by the Root CA and issues certificates to Issuing CAs

locals {
  # Central signing CA configuration
  ca_config = {
    common_name = "hashicorp.local Central Signing CA"
    ttl         = "43800h"  # 5 years
    key_type    = "ec"
    key_bits    = 384       # P-384 curve for central signing CA (stronger than issuing CAs)
  }
}

# PKI Secret Engine for Central Signing CA
resource "vault_mount" "central_signing_ca" {
  path                          = "central-signing-ca"
  type                          = "pki"
  description                   = "Central Signing CA - Intermediate CA for issuing subordinate CAs"
  default_lease_ttl_seconds     = 86400     # 24 hours
  max_lease_ttl_seconds         = 157680000 # 5 years
}

# Generate intermediate CA certificate signing request
resource "vault_pki_secret_backend_intermediate_cert_request" "central_signing_csr" {
  backend      = vault_mount.central_signing_ca.path
  type         = "internal"
  common_name  = local.ca_config.common_name
  
  # Key configuration
  key_type     = local.ca_config.key_type
  key_bits     = local.ca_config.key_bits
  
  # Subject information
  country      = "AU"
  province     = "New South Wales"
  locality     = "Sydney"
  organization = "SEA"
  ou           = "Central PKI"
  
  # Alternative names
  # alt_names = [
  #   "central-signing-ca.hashicorp.local",
  #   "pki.admin.hashicorp.local"
  # ]
  
  # IP SANs for internal access
  ip_sans = [
    "127.0.0.1"
  ]
}

# Sign the CSR with the Root CA (cross-namespace signing)
resource "vault_pki_secret_backend_root_sign_intermediate" "central_signing_signed" {
  backend     = var.root_ca_backend_path
  csr         = vault_pki_secret_backend_intermediate_cert_request.central_signing_csr.csr
  common_name = local.ca_config.common_name
  
  # Use the root CA's intermediate signing role
  use_csr_values = true
  ttl            = local.ca_config.ttl
}

# Install the signed certificate back into the central signing CA
resource "vault_pki_secret_backend_intermediate_set_signed" "central_signing" {
  backend     = vault_mount.central_signing_ca.path
  certificate = vault_pki_secret_backend_root_sign_intermediate.central_signing_signed.certificate
}

# Configure CA URLs for the central signing CA
resource "vault_pki_secret_backend_config_urls" "central_signing_urls" {
  backend                 = vault_mount.central_signing_ca.path
  issuing_certificates    = ["https://vault.hashicorp.local/v1/central-signing-ca/ca"]
  crl_distribution_points = ["https://vault.hashicorp.local/v1/central-signing-ca/crl"]
  
  depends_on = [vault_pki_secret_backend_intermediate_set_signed.central_signing]
}

# Central Signing CA role for signing issuing CAs
resource "vault_pki_secret_backend_role" "issuing_ca_signing" {
  backend     = vault_mount.central_signing_ca.path
  name        = "issuing-ca-signing"
  
  # Certificate parameters
  ttl         = "8760h"    # 1 year for issuing CAs
  max_ttl     = "8760h"    # 1 year maximum
  
  # Key usage and constraints
  allow_any_name      = false
  allow_subdomains    = true
  allowed_domains     = var.organization_domains
  
  # This is the final intermediate level - path length = 0
  key_type            = "ec"
  key_bits            = 256         # P-256 for issuing CAs
  key_usage           = ["cert_signing", "crl_signing"]
  
  # Only allow CA certificates
  allow_localhost     = false
  allow_bare_domains  = false
  allow_ip_sans       = false
  server_flag         = false
  client_flag         = false
  code_signing_flag   = false
  email_protection_flag = false
  
  depends_on = [vault_pki_secret_backend_intermediate_set_signed.central_signing]
}