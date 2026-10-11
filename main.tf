resource "kubernetes_resource_quota_v1" "resource_quota_v1s" {
  for_each = var.resource_quota_v1s


  metadata {
    annotations   = each.value.metadata.annotations
    generate_name = each.value.metadata.generate_name
    labels        = each.value.metadata.labels
    name          = each.value.metadata.name
    namespace     = each.value.metadata.namespace
  }

  dynamic "spec" {
    for_each = each.value.spec != null ? [each.value.spec] : []
    content {
      hard = spec.value.hard
      dynamic "scope_selector" {
        for_each = spec.value.scope_selector != null ? [spec.value.scope_selector] : []
        content {
          dynamic "match_expression" {
            for_each = scope_selector.value.match_expression != null ? scope_selector.value.match_expression : []
            content {
              operator   = match_expression.value.operator
              scope_name = match_expression.value.scope_name
              values     = match_expression.value.values
            }
          }
        }
      }
      scopes = spec.value.scopes
    }
  }

  dynamic "timeouts" {
    for_each = each.value.timeouts != null ? [each.value.timeouts] : []
    content {
      create = timeouts.value.create
      update = timeouts.value.update
    }
  }
}

