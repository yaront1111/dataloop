// GKE Cluster
resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.region
  depends_on = [
    module.network
  ]

  remove_default_node_pool = true
  initial_node_count       = var.initial_node_count

  master_authorized_networks_config {
    cidr_blocks {
      display_name = var.office_display_name
      cidr_block   = var.office_cidr_block
    }
  }

  logging_service    = var.logging_service
  monitoring_service = var.monitoring_service

  network_policy {
    enabled  = var.network_policy_enabled
    provider = var.network_policy_provider
  }

  maintenance_policy {
    daily_maintenance_window {
      start_time = var.maintenance_start_time
    }
  }
}

resource "kubernetes_namespace" "services" {
  metadata {
    name = var.services_namespace
  }
  depends_on = [
    google_container_cluster.primary
  ]
}

resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = var.monitoring_namespace
  }
  depends_on = [
    google_container_cluster.primary
  ]
}
