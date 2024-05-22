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

variable "create_host_catalog" {
  description = "Whether to create the boundary host catalog or not"
  type        = bool
  default     = false
}
