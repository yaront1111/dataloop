output "vpc_name" {
  value       = google_compute_network.vpc.name
  description = "The name of the created VPC"
}

output "subnet_name" {
  value       = google_compute_subnetwork.subnet.name
  description = "The name of the created subnet"
}