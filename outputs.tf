output "resource_quota_v1s_id" {
  description = "Map of id values across all resource_quota_v1s, keyed the same as var.resource_quota_v1s except keys with no id are omitted"
  value       = { for k, v in kubernetes_resource_quota_v1.resource_quota_v1s : k => v.id if v.id != null && length(v.id) > 0 }
}
output "resource_quota_v1s_metadata" {
  description = "Map of metadata values across all resource_quota_v1s, keyed the same as var.resource_quota_v1s except keys with no metadata are omitted"
  value       = { for k, v in kubernetes_resource_quota_v1.resource_quota_v1s : k => one(v.metadata) if v.metadata != null && length(v.metadata) > 0 }
}
output "resource_quota_v1s_spec" {
  description = "Map of spec values across all resource_quota_v1s, keyed the same as var.resource_quota_v1s except keys with no spec are omitted"
  value       = { for k, v in kubernetes_resource_quota_v1.resource_quota_v1s : k => one(v.spec) if v.spec != null && length(v.spec) > 0 }
}

