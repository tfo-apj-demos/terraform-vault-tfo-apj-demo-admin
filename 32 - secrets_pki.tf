module "pki_root" {
  source = "./modules/pki/root"
  
  root_ca_cert         = var.root_ca_cert
  root_ca_key          = var.root_ca_key
  organization_domains = ["hashicorp.local"]
}