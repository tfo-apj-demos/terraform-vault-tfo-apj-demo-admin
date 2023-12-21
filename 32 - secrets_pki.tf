import {
  id = "pki"
  to = vault_mount.pki
}

resource "vault_mount" "pki" {
	type = "pki"
	path = "pki"
}

import {
  id = "pki/config/ca"
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

resource "vault_pki_secret_backend_intermediate_set_signed" "this" {
	backend = vault_mount.pki.path
	certificate =<<EOH
-----BEGIN CERTIFICATE-----
MIID6jCCA3GgAwIBAgITPAAAAAWTr6/h7njmHgAAAAAABTAKBggqhkjOPQQDBDBB
MRUwEwYKCZImiZPyLGQBGRYFbG9jYWwxGTAXBgoJkiaJk/IsZAEZFgloYXNoaWNv
cnAxDTALBgNVBAMTBHJvb3QwHhcNMjMxMTIzMDQyNjM2WhcNMjUxMTIzMDQzNjM2
WjBnMQswCQYDVQQGEwJBVTEPMA0GA1UEBxMGU3lkbmV5MQ4wDAYDVQQKEwVXV1RG
TzEWMBQGA1UECwwNVEZPX0FQSl9ERU1PUzEfMB0GA1UEAxMWSENQIFZhdWx0IElu
dGVybWVkaWF0ZTB2MBAGByqGSM49AgEGBSuBBAAiA2IABPa+1KIuxoKEFxwnGPtq
fjn5faWLJGoUY/N+r82olHMZRx9Cc2Ll+u5zBA30JIyDnJp5qVZpCjXS8CgjOchf
cZG3YMsuVV9NvmtucuaFVyZ5e3/D2KBYhw+31ghiZa5lxqOCAgMwggH/MB0GA1Ud
DgQWBBRJWsFZXYi1yOM62GixZaGENky05zAfBgNVHSMEGDAWgBSgNqfA0i1xcfIR
mDPes6iZGbIXjjCBwwYDVR0fBIG7MIG4MIG1oIGyoIGvhoGsbGRhcDovLy9DTj1y
b290LENOPWRjLTAsQ049Q0RQLENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENO
PVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9aGFzaGljb3JwLERDPWxvY2Fs
P2NlcnRpZmljYXRlUmV2b2NhdGlvbkxpc3Q/YmFzZT9vYmplY3RDbGFzcz1jUkxE
aXN0cmlidXRpb25Qb2ludDCBugYIKwYBBQUHAQEEga0wgaowgacGCCsGAQUFBzAC
hoGabGRhcDovLy9DTj1yb290LENOPUFJQSxDTj1QdWJsaWMlMjBLZXklMjBTZXJ2
aWNlcyxDTj1TZXJ2aWNlcyxDTj1Db25maWd1cmF0aW9uLERDPWhhc2hpY29ycCxE
Qz1sb2NhbD9jQUNlcnRpZmljYXRlP2Jhc2U/b2JqZWN0Q2xhc3M9Y2VydGlmaWNh
dGlvbkF1dGhvcml0eTAZBgkrBgEEAYI3FAIEDB4KAFMAdQBiAEMAQTAPBgNVHRMB
Af8EBTADAQH/MA4GA1UdDwEB/wQEAwIBhjAKBggqhkjOPQQDBANnADBkAjAcO6Gp
PJXpOE6deiEK0g54QxGAEBm6g9L6tAXD6B64L89Ltw7be6buB7o/NPnroxwCMEok
Nz8cPTDNXzSWTBgmC37224PMvhLr50LVrlHdS+7RuRaQ63vYVnadJ6oMn85Thw==
-----END CERTIFICATE-----
EOH
}

import {
  id = "pki/roles/gcve"
  to = vault_pki_secret_backend_role.gcve
}

resource "vault_pki_secret_backend_role" "gcve" {
	name = "gcve"
	backend = vault_mount.pki.path
	max_ttl = "259200"
	ttl = "259200"
	allowed_domains = [
		"hashicorp.local"
	]
	allowed_uri_sans = [
		"*.hashicorp.local",
		"vault.hashicorp.local"
	]
	allow_ip_sans = true
	allow_subdomains = true
	enforce_hostnames = false
}