# AppRole auth backend for Ansible Automation Platform (AAP)
# Used by AAP to authenticate and issue certificates from the issuing-ca PKI engine

resource "vault_auth_backend" "approle" {
  type = "approle"
}

resource "vault_approle_auth_backend_role" "aap_clm" {
  backend        = vault_auth_backend.approle.path
  role_name      = "aap-clm"
  token_policies = ["generate_certificate", "issuing-ca-access"]

  token_ttl     = 3600  # 1 hour
  token_max_ttl = 14400 # 4 hours
}

resource "vault_approle_auth_backend_role_secret_id" "aap_clm" {
  backend   = vault_auth_backend.approle.path
  role_name = vault_approle_auth_backend_role.aap_clm.role_name
}
