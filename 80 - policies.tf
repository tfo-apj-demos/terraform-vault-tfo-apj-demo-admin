# --- Loop over the policy directory and create policies
# --- that match the file names in it.
resource "vault_policy" "this" {
    for_each = fileset("${path.module}/policies", "*.hcl")
    name = trimsuffix(each.value, ".hcl")
    policy = file("${path.module}/policies/${each.value}")
}   

