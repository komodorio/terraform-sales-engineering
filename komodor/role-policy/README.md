# role-policy

```tf
module "role-policy" {
  source = "./modules/role-policy"
}
```

Example tfvars (Set in module call above)

```tf terraform.tfvars
komodor_api_key = "some_api_key"
cluster_name = "komo-workshop-sdhcod8k"
namespace = "default"
komodor_role_name = "terraform-generated-role"
komoodor_role_policy_attachment_name = "terraform-generated-role-policy-attachment"
policy_scoping = {
  entire_cluster = {
    name = "entire-cluster-view-nodes"
    actions = ["view:all"]
    cluster = "komo-workshop-sdhcod8k"
  }
  cluster_wide_actions = {
    name = "cluster-wide-bank-of-anthos-cordon-nodes"
    actions = ["cordon:node"]
    cluster = "komo-workshop-sdhcod8k"
    selector = {
      key   = "application"
      value = "bank-of-anthos"
      type  = "label"
    }
  }
  admin_actions = {
    name = "admin-manage-agents"
    actions = ["manage:agents"]
  }
  namespaced_actions = {
    name      = "namespaced-view-deployments-services-default-ns"
    actions   = ["get:deployment"]
    cluster   = "komo-workshop-sdhcod8k"
    namespace = "default"
  }
}
```