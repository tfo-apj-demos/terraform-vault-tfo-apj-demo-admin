variable "namespace" {
  description = "The namespace to provision the root CA in (use null for root namespace)"
  type        = string
  default     = null
}

variable "root_ca_cert" {
  description = "The root CA certificate content"
  type        = string
}

variable "root_ca_key" {
  description = "The root CA private key content"
  type        = string
  sensitive   = true
}

variable "organization_domains" {
  description = "List of domains that the CA can issue certificates for"
  type        = list(string)
  default     = ["hashibank.com", "hashibank.local", "vault.hashibank.com"]
}
