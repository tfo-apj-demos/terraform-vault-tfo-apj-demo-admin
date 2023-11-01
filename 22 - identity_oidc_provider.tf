resource "vault_identity_oidc" "this" {
  issuer = "https://production.vault.11eb56d6-0f95-3a99-a33c-0242ac110007.aws.hashicorp.cloud:8200"
}

resource "vault_identity_oidc_assignment" "team_se" {
  name       = "team_se"
  group_ids  = [
    vault_identity_group.team_se.id
  ]
  entity_ids = [ 
    for v in vault_identity_entity.se: v.id
  ]
}

resource "vault_identity_oidc_key" "team_se" {
  name      = "team_se"
  algorithm = "RS256"
  verification_ttl = 7200
  rotation_period = 7200
}

resource "vault_identity_oidc_client" "boundary" {
  name          = "boundary"
  redirect_uris = [
    "https://8b596635-91df-45a3-8455-1ecbf5e8c43e.boundary.hashicorp.cloud/v1/auth-methods/oidc:authenticate:callback",
    "http://127.0.0.1:8251/callback"
  ]
  assignments = [
    vault_identity_oidc_assignment.team_se.name
  ]
  id_token_ttl     = 2400
  access_token_ttl = 7200
  key = vault_identity_oidc_key.team_se.id
}

resource "vault_identity_oidc_scope" "team_se" {
  name        = "groups"
  template    = "{\"groups\":{{identity.entity.groups.names}}}"
}

resource "vault_identity_oidc_provider" "team_se" {
  name = "team_se"
  https_enabled = true
  issuer_host = "production.vault.11eb56d6-0f95-3a99-a33c-0242ac110007.aws.hashicorp.cloud:8200"
  scopes_supported = [
    vault_identity_oidc_scope.team_se.name
  ]
  allowed_client_ids = [
    vault_identity_oidc_client.boundary.client_id
  ]
}

resource "vault_identity_oidc_role" "team_se" {
  name = "team_se"
  key  = vault_identity_oidc_key.team_se.name
  ttl = 60
}

resource "vault_identity_oidc_key_allowed_client_id" "team_se" {
  key_name          = vault_identity_oidc_key.team_se.name
  allowed_client_id = vault_identity_oidc_client.boundary.client_id
}