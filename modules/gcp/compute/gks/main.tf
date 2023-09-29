// Initialize the GCP provider
provider "google" {
  credentials = file(var.credentials_path)
  project     = var.project_id
  region      = var.region
}

// Create a VPC network
resource "google_compute_network" "vpc_network" {
  name = "gke-network"
}

// Create a GKE cluster
resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.region

  remove_default_node_pool = true
  initial_node_count       = var.initial_node_count

  master_authorized_networks_config {
    cidr_blocks {
      display_name = "office"
      cidr_block   = "192.168.0.0/16"
    }
  }

  network    = google_compute_network.vpc_network.name
  subnetwork = google_compute_subnetwork.subnet.name

  logging_service    = "logging.googleapis.com/kubernetes"
  monitoring_service = "monitoring.googleapis.com/kubernetes"

  network_policy {
    enabled  = true
    provider = "CALICO"
  }

  maintenance_policy {
    daily_maintenance_window {
      start_time = "03:00"
    }
  }
}

// Create a subnetwork
resource "google_compute_subnetwork" "subnet" {
  name          = "gke-subnet"
  ip_cidr_range = "10.0.0.0/16"
  region        = var.region
  network       = google_compute_network.vpc_network.name
}
