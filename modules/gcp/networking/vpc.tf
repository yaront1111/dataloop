// GCP VPC
resource "google_compute_network" "vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks = var.auto_create_subnetworks
  routing_mode            = var.routing_mode
  description             = var.vpc_description
}
resource "google_compute_network_label" "vpc_label" {
  network = google_compute_network.vpc.name
  labels = {
    environment = var.envtags
  }
}