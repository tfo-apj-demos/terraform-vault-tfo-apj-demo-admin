resource "vault_mount" "ssh" {
    type = "ssh"
		path = "ssh"
}

resource "vault_ssh_secret_backend_ca" "this" {
    backend = vault_mount.ssh.path
		generate_signing_key = true
}

resource "vault_ssh_secret_backend_role" "this" {
	backend = vault_mount.ssh.path
	name = "boundary"
	allow_user_certificates = true
  default_user = "ubuntu"
  allowed_users = "*"
  key_type = "ca"
  ttl = "28800"
  max_ttl = "28800"
  default_extensions = {"permit-pty"=""}
  allowed_extensions = "permit-pty,permit-port-forwarding"

}

