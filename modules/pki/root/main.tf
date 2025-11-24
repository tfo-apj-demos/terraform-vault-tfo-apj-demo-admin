# Root CA Module - External/Offline Root CA in Root Namespace
# This mocks up an external root CA by importing existing certificates

# PKI Secret Engine for Root CA (in root namespace)
resource "vault_mount" "root_ca" {
  path                          = "root-ca"
  type                          = "pki"
  description                   = "Root CA - External/Offline (Imported)"
  default_lease_ttl_seconds     = 86400     # 24 hours
  max_lease_ttl_seconds         = 315360000 # 10 years
}

# Import the external root CA certificate and key
resource "vault_pki_secret_backend_config_ca" "root_ca_import" {
  backend     = vault_mount.root_ca.path
  pem_bundle  = "${var.root_ca_cert}${var.root_ca_key}"
}

# Configure CA URLs for the root CA
resource "vault_pki_secret_backend_config_urls" "root_ca_urls" {
  backend                 = vault_mount.root_ca.path
  issuing_certificates    = ["https://vault.hashicorp.local.com/v1/root-ca/ca"]
  crl_distribution_points = ["https://vault.hashicorp.com/v1/root-ca/crl"]
}

# Root CA role for signing intermediate CAs only
resource "vault_pki_secret_backend_role" "intermediate_ca_signing" {
  backend             = vault_mount.root_ca.path
  name                = "intermediate-ca-signing"
  
  # Certificate parameters
  ttl                 = "43800h"    # 5 years for intermediate CAs
  max_ttl             = "43800h"    # 5 years maximum
  
  # Key usage and constraints
  allow_any_name      = false
  allow_subdomains    = true
  allowed_domains     = var.organization_domains
  
  # Path length constraint - allows exactly 1 intermediate (central signing CA)
  # The central signing CA can then issue one more level (issuing CAs)
  key_type            = "ec"
  key_bits            = 256         # P-256 for intermediate CAs
  key_usage           = ["cert_signing", "crl_signing"]
  
  # Only allow CA certificates
  allow_localhost     = false
  allow_bare_domains  = false
  allow_ip_sans       = false
  server_flag         = false
  client_flag         = false
  code_signing_flag   = false
  email_protection_flag = false
}