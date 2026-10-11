variable "resource_quota_v1s" {
  description = <<EOT
Map of resource_quota_v1s, attributes below
Required:
    - metadata (block):
        - annotations (optional)
        - generate_name (optional)
        - labels (optional)
        - name (optional)
        - namespace (optional)
Optional:
    - spec (block):
        - hard (optional)
        - scope_selector (optional, block):
            - match_expression (optional, block):
                - operator (required)
                - scope_name (required)
                - values (optional)
        - scopes (optional)
    - timeouts (block):
        - create (optional)
        - update (optional)
EOT

  type = map(object({
    metadata = object({
      annotations   = optional(map(string))
      generate_name = optional(string)
      labels        = optional(map(string))
      name          = optional(string)
      namespace     = optional(string)
    })
    spec = optional(object({
      hard = optional(map(string))
      scope_selector = optional(object({
        match_expression = optional(list(object({
          operator   = string
          scope_name = string
          values     = optional(set(string))
        })))
      }))
      scopes = optional(set(string))
    }))
    timeouts = optional(object({
      create = optional(string)
      update = optional(string)
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.resource_quota_v1s : (
        v.spec == null || (v.spec.scopes == null || (alltrue([for x in v.spec.scopes : contains(["Terminating", "NotTerminating", "BestEffort", "NotBestEffort", "PriorityClass"], x)])))
      )
    ])
    error_message = "must be one of: \"Terminating\", \"NotTerminating\", \"BestEffort\", \"NotBestEffort\", \"PriorityClass\""
  }
  validation {
    condition = alltrue([
      for k, v in var.resource_quota_v1s : (
        v.spec == null || (v.spec.scope_selector == null || (v.spec.scope_selector.match_expression == null || alltrue([for item in v.spec.scope_selector.match_expression : (contains(["Terminating", "NotTerminating", "BestEffort", "NotBestEffort", "PriorityClass"], item.scope_name))])))
      )
    ])
    error_message = "must be one of: \"Terminating\", \"NotTerminating\", \"BestEffort\", \"NotBestEffort\", \"PriorityClass\""
  }
  validation {
    condition = alltrue([
      for k, v in var.resource_quota_v1s : (
        v.spec == null || (v.spec.scope_selector == null || (v.spec.scope_selector.match_expression == null || alltrue([for item in v.spec.scope_selector.match_expression : (contains(["In", "NotIn", "Exists", "DoesNotExist"], item.operator))])))
      )
    ])
    error_message = "must be one of: \"In\", \"NotIn\", \"Exists\", \"DoesNotExist\""
  }
  # Note: 1 additional provider-side validator is enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

