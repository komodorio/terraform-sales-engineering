output "role_policy_info" {
  value = [
    {
        role_name = komodor_role.this.name
        role_id   = komodor_role.this.id
        policies  = komodor_policy_role_attachment.this.policies
    }
  ]
}