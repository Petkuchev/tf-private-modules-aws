locals {
  oidc_identity_provider = [for k, identity_provider in var.cluster_identity_providers : identity_provider if identity_provider.name == "oidc"]
}

resource "kubernetes_cluster_role_binding" "ClusterAdmins" {
  count = length(local.oidc_identity_provider)

  metadata {
    name = "AzureAD2ClusterAdmin"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }
  subject {
    kind      = "Group"
    name      = local.oidc_identity_provider[0].AzureGroupID
    api_group = "rbac.authorization.k8s.io"
  }
}