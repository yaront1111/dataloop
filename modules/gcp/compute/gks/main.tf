// GKE Cluster
resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = "us-central1-f"
  network  = var.vpc_name
  subnetwork = var.subnet_name
  deletion_protection = false

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

  provisioner "local-exec" {
    command = "gcloud container clusters get-credentials ${self.name} --zone=${self.location}"
  }
}


resource "google_container_node_pool" "primary_nodes" {
  name       = "my-node-pool"
  cluster    = var.cluster_name
  location   = "us-central1-f"
  node_count = 1

  node_config {
    machine_type = "e2-medium"
    disk_size_gb = 100
    disk_type    = "pd-standard"
    metadata = {
      disable-legacy-endpoints = "true"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
  depends_on = [google_container_cluster.primary]
}
resource "kubernetes_namespace" "this" {
  depends_on = [google_container_cluster.primary]
  for_each = { for ns in var.namespaces : ns.name => ns }

  metadata {
    name = each.value.name
  }
}

locals {
  sensitive   = true
  cluster_ca_certificate = data.google_container_cluster.gke_cluster.master_auth != null ? data.google_container_cluster.gke_cluster.master_auth[0].cluster_ca_certificate : ""
  private_endpoint       = try(data.google_container_cluster.gke_cluster.private_cluster_config[0].private_endpoint, "")
  default_endpoint       = data.google_container_cluster.gke_cluster.endpoint != null ? data.google_container_cluster.gke_cluster.endpoint : ""
  endpoint               = var.use_private_endpoint == true ? local.private_endpoint : local.default_endpoint
  host                   = local.endpoint != "" ? "https://${local.endpoint}" : ""
  context                = data.google_container_cluster.gke_cluster.name != null ? data.google_container_cluster.gke_cluster.name : ""
}


data "google_container_cluster" "gke_cluster" {
  name     = var.cluster_name
  location = var.location
  project  = var.project_id
  depends_on = [google_container_cluster.primary]
}

data "google_client_config" "provider" {}