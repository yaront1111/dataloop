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

resource "google_container_node_pool" "primary_nodes" {
  name       = "my-node-pool"
  cluster    = var.cluster_name
  location   = var.region
  node_count = 1

  node_config {
    machine_type = "e2-micro"
    disk_size_gb = 10
    disk_type    = "pd-standard"
    metadata = {
      disable-legacy-endpoints = "true"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}
resource "kubernetes_namespace" "this" {
  for_each = { for ns in var.namespaces : ns.name => ns }

  metadata {
    name = each.value.name
  }
}