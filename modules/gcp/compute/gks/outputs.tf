output "gke_cluster_name" {
  value       = google_container_cluster.primary.name
  description = "The name of the GKE cluster."
}

output "gke_cluster_endpoint" {
  value       = google_container_cluster.primary.endpoint
  description = "The IP address of the GKE Kubernetes master endpoint."
}

output "gke_cluster_ca_certificate" {
  value       = google_container_cluster.primary.master_auth.0.cluster_ca_certificate
  description = "The CA certificate of the GKE cluster for connecting securely."
}

output "cluster_location" {
  value       = google_container_cluster.primary.location
  description = "The location of the GKE cluster."
}

output "host" {
  description = "The host value for use with the kubernetes provider."
  value       = local.host
}

output "token" {
  sensitive   = true
  description = "The token value for use with the kubernetes provider."
  value       = data.google_client_config.provider.access_token
}
output "client_certificate" {
  value = google_container_cluster.primary.master_auth.0.client_certificate
}

output "client_key" {
  value = google_container_cluster.primary.master_auth.0.client_key
}