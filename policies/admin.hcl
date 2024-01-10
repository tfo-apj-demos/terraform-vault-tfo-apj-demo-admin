# --- Lookup token 
path "/sys/capabilities-self" {
    capabilities = ["update"]
}

# --- Manage policies
path "/sys/policies" {
  capabilities = ["list", "read"]
}

path "/sys/policies/+" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

# --- Manage namespaces
path "sys/namespaces/*" {
  capabilities = ["create", "read", "update", "delete"]
}

path "sys/namespaces" {
  capabilities = ["list"]
}

# --- Manage auth methods
path "sys/auth" {
  capabilities = ["list","read"]
}

path "sys/auth/*" {
  capabilities = ["create", "read", "update", "delete", "sudo"]
}

path "auth/*" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

# --- Mangage roles for any auth/secret engine
path "+/roles/+" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

path "+/role/+" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

# --- Manage secret engines
path "sys/mounts/+" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

path "sys/mounts" {
  capabilities = ["read", "list"]
}

# --- Interact with transit
path "transit" {
  capabilities = [ 
    "read"
  ]
}

path "transit/keys" {
  capabilities = [
    "list"
  ]
}

path "transit/keys/+" {
  capabilities = [
    "read"
  ]
}

# --- Manage PKI engine
path "+/intermediate/set-signed" {
	capabilities = ["create", "update", "delete", "sudo" ]
}


# --- Issue creds for any engine
path "+/creds/+" {
	capabilities = ["read"]
}


# --- Manage entities and aliases
path "identity/+" {
  capabilities = [ "create", "read", "update", "delete", "list" ]
}

path "entities/+" {
  capabilities = [ "create", "read", "update", "delete", "list" ]
}


# --- Manage Performance Replication
path "sys/replication" {
	capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}


# --- Read health checks
path "sys/health" {
  capabilities = ["read", "sudo"]
}


# --- Manage audit devices
path "sys/audit/+" {
	capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}


# --- Relocate mounts
path "sys/remount" {
	capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}