variable "scope_name" {
  type = string
}

variable "parent_scope_id" {
  type = string
}

variable "vault_address" {
  type = string
}

variable "project_admin_principal_ids" {
  type = list(string)
}

variable "ldap_credential_library" {
  description = "Determines if the LDAP credential library should be created"
  type        = bool
  default     = false
}
