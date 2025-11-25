import {
  id = "pki"
  to = vault_mount.pki
}

resource "vault_mount" "pki" {
	type = "pki"
	path = "pki"
}
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

# 1. Root CA (External/Offline Root CA in the tfo-apj-demos namespace)
module "pki_root" {
  source = "./modules/pki/root"
  
  root_ca_cert         = var.root_ca_cert
  root_ca_key          = var.root_ca_key
  organization_domains = ["hashicorp.local"]
}

# 2. Central Signing CA (Intermediate CA in tfo-apj-demos namespace)
module "pki_central_signing" {
  source = "./modules/pki/central-signing"
  
  root_ca_backend_path   = module.pki_root.backend_path
  organization_domains   = ["hashicorp.local"]
  
  depends_on = [module.pki_root]
}

# 3. Issuing CA (End-entity certificate issuer)
module "pki_issuing" {
  source = "./modules/pki/issuing"
  
  central_signing_backend_path = module.pki_central_signing.backend_path
  
  depends_on = [module.pki_central_signing]
}