variable "cluster_name" {}

variable "actions" {
  default = [
    "view:cost",
    "add:helm-repo",
    "install:helm-chart",
    "manage:helm",
    "read:helm-repo",
    "remove:helm-repo",
    "revert:helm-chart",
    "uninstall:helm-chart",
    "update:helm-repo",
    "delete:cronjob",
    "delete:daemonset",
    "delete:deployment",
    "delete:ingress",
    "delete:job",
    "delete:networkpolicy",
    "delete:persistentvolumeclaim",
    "delete:pod",
    "delete:replicaset",
    "delete:rollout",
    "delete:service",
    "delete:statefulset",
    "edit:configmap",
    "edit:cronjob",
    "edit:daemonset",
    "edit:deployment",
    "edit:horizontalpodautoscaler",
    "edit:job",
    "edit:replicaset",
    "edit:secret",
    "edit:service",
    "edit:statefulset",
    "exec:pod",
    "forward:port",
    "get:daemonset",
    "get:deployment",
    "get:statefulset",
    "rerun:job",
    "restart:daemonset",
    "restart:deployment",
    "restart:rollout",
    "restart:statefulset",
    "rollback:daemonset",
    "rollback:deployment",
    "rollback:statefulset",
    "run:cronjob",
    "scale:deployment",
    "scale:rollout",
    "scale:statefulset",
    "view:all"
  ]
}

variable "policy_scoping" {
  # Each represents a discrete policy object
  type = object({
    entire_cluster = optional(object({
      name = string
      cluster = string
      actions = list(string)
    }))
    admin_actions = optional(object({
      name = string
      actions = list(string)
    }))
    cluster_wide_actions = optional(object({
      name = string
      cluster = string
      # Selectors must exist before you set them here.
      selector = optional(object({
        key   = string
        value = string
        type  = string
      }))
      actions = list(string)
    }))
    namespaced_actions = optional(object({
      name = string
      cluster   = string
      namespace = string
      actions = list(string)
    }))
  })
}


variable "komodor_api_key" {}

variable "komodor_policy_name" {
  default = "Komodor Role Policy"
}

variable "namespace" {}

variable "komodor_role_name" {}

variable "komoodor_role_policy_attachment_name" {}
