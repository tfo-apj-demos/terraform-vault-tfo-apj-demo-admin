resource "vault_jwt_auth_backend_role" "boundary_admin" {
  backend         = "jwt_tfc"
  role_name       = "boundary_admin"
  token_policies  = [
    vault_policy.generate_tfc_token.name,
    "default"
  ]

  bound_audiences = [
    "vault.tfc.workspace.identity"
  ]
  bound_claims_type = "glob"
  bound_claims = {
    sub = "organization:tfo-apj-demos:project:10 - gcve-foundations:workspace:boundary-admin:run_phase:*"
    terraform_organization_id = "org-6nfrqkZhPPHJWG5h"
  }
  user_claim      = "terraform_full_workspace"
  role_type       = "jwt"

  claim_mappings = {
    terraform_project_id = "terraform_project_id"
    terraform_workspace_id = "terraform_workspace_id"
  }
}