// GKE Cluster
resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.region

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
resource "google_container_cluster_node_pool" "primary" {
  name = "primary-pool"
  cluster = google_container_cluster.primary.name

  node_count = var.initial_node_count

  machine_type = "e2-micro"
}

resource "kubernetes_namespace" "this" {
  for_each = { for ns in var.namespaces : ns.name => ns }

  metadata {
    name = each.value.name
  }
}