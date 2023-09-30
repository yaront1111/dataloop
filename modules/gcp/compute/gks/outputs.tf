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

output "services_namespace" {
  value       = kubernetes_namespace.services.metadata.0.name
  description = "The name of the 'services' namespace."
}

output "monitoring_namespace" {
  value       = kubernetes_namespace.monitoring.metadata.0.name
  description = "The name of the 'monitoring' namespace."
}