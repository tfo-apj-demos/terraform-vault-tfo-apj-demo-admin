resource "vault_jwt_auth_backend_role" "boundary_admins" {
  backend         = "jwt_tfc"
  role_name       = "boundary_admins"
  token_policies  = [
    #vault_policy.generate_tfc_token.name,
    "default"
  ]

  bound_audiences = [
    "vault.tfc.workspace.identity"
  ]
  bound_claims_type = "glob"
  bound_claims = {
    sub = "organization:tfo-apj-demos:project:10 - gcve-foundations:workspace:*:run_phase:*"
    terraform_organization_id = "org-6nfrqkZhPPHJWG5h"
  }
  user_claim      = "terraform_full_workspace"
  role_type       = "jwt"

  claim_mappings = {
    terraform_project_id = "terraform_project_id"
    terraform_workspace_id = "terraform_workspace_id"
  }
}

resource "vault_jwt_auth_backend_role" "tfc" {
  backend         = "jwt_tfc"
  role_name       = "tfc"
  token_policies  = [
    "terraform_cloud",
    "vault_unseal",
    "generate_certificate",
    "create_child_token",
    ]

  bound_audiences = [
    "vault.tfc.workspace.identity"
  ]
  bound_claims_type = "glob"
  bound_claims = {
    sub = "organization:tfo-apj-demos:*"
    terraform_organization_id = "org-6nfrqkZhPPHJWG5h"
  }
  user_claim      = "terraform_full_workspace"
  role_type       = "jwt"

  claim_mappings = {
    terraform_project_id = "terraform_project_id"
    terraform_workspace_id = "terraform_workspace_id"
  }
}
