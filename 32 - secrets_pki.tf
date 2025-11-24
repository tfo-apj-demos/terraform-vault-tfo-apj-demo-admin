import {
  id = "pki"
  to = vault_mount.pki
}

resource "vault_mount" "pki" {
	type = "pki"
	path = "pki"
}

# import {
#   id = "pki/config/ca"
#   to = 
# }

resource "vault_pki_secret_backend_config_ca" "this" {
	backend = vault_mount.pki.path
	pem_bundle = <<EOH
-----BEGIN CERTIFICATE-----
MIICJzCCAaygAwIBAgIQbn3a3bybm4RDhMIGFhZPcTAKBggqhkjOPQQDBDBBMRUw
EwYKCZImiZPyLGQBGRYFbG9jYWwxGTAXBgoJkiaJk/IsZAEZFgloYXNoaWNvcnAx
DTALBgNVBAMTBHJvb3QwHhcNMjMxMTIxMDYyNjI4WhcNMjgxMTIxMDYzNjI3WjBB
MRUwEwYKCZImiZPyLGQBGRYFbG9jYWwxGTAXBgoJkiaJk/IsZAEZFgloYXNoaWNv
cnAxDTALBgNVBAMTBHJvb3QwdjAQBgcqhkjOPQIBBgUrgQQAIgNiAASHn0R2nubu
WihsZAto+2NiGp5aPO9RU8lCdrFpn4q5v7/15c03rMvLSGaPWueqLaeeuw1DGwua
2z8qmNDTAs1i16o4MX53X7fSdR6ZqAQhQg8keN54FJoQ7XH8ZcqusOijaTBnMBMG
CSsGAQQBgjcUAgQGHgQAQwBBMA4GA1UdDwEB/wQEAwIBhjAPBgNVHRMBAf8EBTAD
AQH/MB0GA1UdDgQWBBSgNqfA0i1xcfIRmDPes6iZGbIXjjAQBgkrBgEEAYI3FQEE
AwIBADAKBggqhkjOPQQDBANpADBmAjEAlWq0q+yCIh8blUbwuTgviS28REb0lSRy
zrM7+vEt/KAarK9mPPg7Eop4MEiGhMz9AjEAx5suBunl6NSLDMpASeSkzdD+QElV
SRhpTJqh1IW9s+jARBtT1+SJiO3ZXTs7INMm
-----END CERTIFICATE-----
EOH
}

# resource "vault_pki_secret_backend_intermediate_cert_request" "this" {
#  backend      = vault_mount.pki.path
#  type         = "internal"
#  common_name  = "HCP Vault Intermediate"
#  key_type     = "ec"
#  key_bits     = "384"
#  organization = "WWTFO"
#  ou           = "TFO_APJ_DEMOS"
#  country      = "AU"
#  locality     = "Sydney"

# }

# Generate intermediate CA certificate signing request
resource "vault_pki_secret_backend_intermediate_cert_request" "this" {
	backend      = vault_mount.pki.path
	type         = "internal"
	common_name  = "HCP Vault Intermediate"

	# Key configuration
	key_type     = "ec"
	key_bits     = 384

	# Subject information
	organization = "WWTFO"
	ou           = "TFO_APJ_DEMOS"
	country      = "AU"
	locality     = "Sydney"
}

# Sign the intermediate CSR with the root CA
# NOTE: This assumes you have access to sign with the root CA
# You may need to adjust this based on your root CA setup
resource "vault_pki_secret_backend_root_sign_intermediate" "this" {
	backend     = vault_mount.pki.path
	csr         = vault_pki_secret_backend_intermediate_cert_request.this.csr
	common_name = "HCP Vault Intermediate"

	# TTL for intermediate CA - 2 years
	ttl         = "17520h"  # 730 days / 2 years

	# Use CSR values for subject information
	use_csr_values = true

	# Key usage for intermediate CA
	# Allows this intermediate to sign certificates but not other intermediates
	# max_path_length = 0 means this intermediate cannot sign other intermediates
	max_path_length = 0
}

# Install the signed certificate back into the intermediate CA
resource "vault_pki_secret_backend_intermediate_set_signed" "this" {
	backend     = vault_mount.pki.path
	certificate = vault_pki_secret_backend_root_sign_intermediate.this.certificate
}

# Configure CA URLs for certificate distribution
resource "vault_pki_secret_backend_config_urls" "config_urls" {
	backend                 = vault_mount.pki.path
	issuing_certificates    = ["https://production.vault.11eb56d6-0f95-3a99-a33c-0242ac110007.aws.hashicorp.cloud:8200/v1/admin/tfo-apj-demos/pki/ca"]
	crl_distribution_points = ["https://production.vault.11eb56d6-0f95-3a99-a33c-0242ac110007.aws.hashicorp.cloud:8200/v1/admin/tfo-apj-demos/pki/crl"]

	depends_on = [vault_pki_secret_backend_intermediate_set_signed.this]
}

import {
  id = "pki/roles/gcve"
  to = vault_pki_secret_backend_role.gcve
}

resource "vault_pki_secret_backend_role" "gcve" {
	name    = "gcve"
	backend = vault_mount.pki.path

	# TTL Configuration - 30 days for server certificates
	# This is well within the intermediate CA's 2-year validity
	ttl     = "720h"   # 30 days
	max_ttl = "720h"   # 30 days maximum

	# Domain and naming constraints
	allowed_domains = [
		"hashicorp.local"
	]
	allowed_uri_sans = [
		"*.hashicorp.local",
		"vault.hashicorp.local"
	]
	allow_ip_sans       = true
	allow_subdomains    = true
	enforce_hostnames   = false

	# Key configuration
	key_type = "ec"
	key_bits = 256

	# Key usage for server/client certificates
	key_usage = ["digital_signature", "key_encipherment"]
	ext_key_usage = ["server_auth", "client_auth"]

	# Certificate flags
	server_flag = true
	client_flag = true

	depends_on = [vault_pki_secret_backend_intermediate_set_signed.this]
}