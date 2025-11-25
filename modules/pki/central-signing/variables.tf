variable "root_ca_backend_path" {
  description = "The backend path of the root CA"
  type        = string
}

variable "organization_domains" {
  description = "List of domains that the CA can issue certificates for"
  type        = list(string)
  default     = ["hashibank.com", "hashibank.local", "vault.hashibank.com"]
}
