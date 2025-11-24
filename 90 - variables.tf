variable "tfc_organization" {
  type = string
  default = "tfo-apj-demos"
}

variable "tfc_workspace" {
  type = string
  default = "github-identities"
}

variable "tfc_token" {
  type = string
}

variable "boundary_address" {
  type = string
}

variable "service_account_authmethod_id" {
  type = string
}

variable "service_account_name" {
  type = string
}

variable "service_account_password" {
  type = string
}

variable "gcve_admin_github_alisases" {
  type = list(string)
}

variable "root_ca_cert" {
  type      = string
  sensitive = true
}

variable "root_ca_key" {
  type      = string
  sensitive = true
}