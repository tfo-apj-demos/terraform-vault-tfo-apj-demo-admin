variable "namespace" {
  description = "The namespace to provision the central signing CA in"
  type        = string
  default     = "admin"
}

variable "root_ca_namespace" {
  description = "The namespace where the root CA is located (use null for root namespace)"
  type        = string
  default     = null
}

variable "root_ca_backend_path" {
  description = "The backend path of the root CA"
  type        = string
}

variable "organization_domains" {
  description = "List of domains that the CA can issue certificates for"
  type        = list(string)
  default     = ["hashibank.com", "hashibank.local", "vault.hashibank.com"]
}
