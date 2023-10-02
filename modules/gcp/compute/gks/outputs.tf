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
output "kubeconfig" {
  value = <<EOT
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: ${google_container_cluster.primary.master_auth.0.cluster_ca_certificate}
    server: https://${google_container_cluster.primary.endpoint}
  name: ${google_container_cluster.primary.name}
EOT
  description = "The kubeconfig configuration file."
}

output "cluster_location" {
  value       = google_container_cluster.primary.location
  description = "The location of the GKE cluster."
}