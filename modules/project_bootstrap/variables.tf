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

variable "connect_only_principal_ids" {
  type = list(string)
  default = []
}