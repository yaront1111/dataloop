// GCP Firewall Rules
resource "google_compute_firewall" "fw_rules" {
  name    = var.firewall_name
  network = var.vpc_name

  allow {
    protocol = var.allowed_protocol
    ports    = var.allowed_ports
  }

  source_ranges = var.source_ranges
  depends_on = [
    google_compute_network.vpc
  ]
}
