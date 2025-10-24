
resource "komodor_role" "this" {
  name = var.komodor_role_name
}

resource "komodor_policy_v2" "entire_cluster" {
  count = var.policy_scoping.entire_cluster != null ? 1 : 0
  name = var.policy_scoping.entire_cluster.name
    statements {
      actions = var.policy_scoping.entire_cluster.actions
      resources_scope {
        clusters = [var.policy_scoping.entire_cluster.cluster]
        # TODO this should not be needed but the provider crashes if left blank
        namespaces = ["*"]
      }
    }
}

resource "komodor_policy_v2" "cluster_wide_actions" {
  count = var.policy_scoping.cluster_wide_actions != null ? 1 : 0
  name = var.policy_scoping.cluster_wide_actions.name
  statements {
    actions = var.policy_scoping.cluster_wide_actions.actions
    resources_scope {
      clusters = [var.policy_scoping.cluster_wide_actions.cluster]
      selectors {
        key   = var.policy_scoping.cluster_wide_actions.selector.key
        value = var.policy_scoping.cluster_wide_actions.selector.value
        type = var.policy_scoping.cluster_wide_actions.selector.type
      }
    }
  }
}


resource "komodor_policy_v2" "admin_actions" {
  count = var.policy_scoping.admin_actions != null ? 1 : 0
  name = var.policy_scoping.admin_actions.name
  statements {
    actions = var.policy_scoping.admin_actions.actions
    resources_scope {
      # Admin actions are not scoped to any cluster or namespace
      # TODO If left blank the provider crashses despite not being needed for ad
      clusters = ["*"]
      namespaces = ["*"]
    }
  }
}

resource "komodor_policy_v2" "namespaced_actions" {
  count = var.policy_scoping.namespaced_actions != null ? 1 : 0
  name  = var.policy_scoping.namespaced_actions.name
  statements {
    actions = var.policy_scoping.namespaced_actions.actions
    resources_scope {
      clusters = [var.policy_scoping.namespaced_actions.cluster]
      namespaces = [var.policy_scoping.namespaced_actions.namespace]
    }
  }
}

resource "komodor_policy_role_attachment" "this" {
  name = var.komoodor_role_policy_attachment_name
  policies = [
    komodor_policy_v2.cluster_wide_actions[0].id,
    komodor_policy_v2.namespaced_actions[0].id,
    komodor_policy_v2.admin_actions[0].id,
    komodor_policy_v2.entire_cluster[0].id,
]
  role = komodor_role.this.id
}