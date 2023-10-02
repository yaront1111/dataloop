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

output "kubeconfig_raw" {
  sensitive   = true
  description = "A kubeconfig file configured to access the GKE cluster."
  value = templatefile("${path.module}/templates/kubeconfig-template.yaml.tpl", {
    context                = local.context
    cluster_ca_certificate = local.cluster_ca_certificate
    endpoint               = local.endpoint
    token                  = data.google_client_config.provider.access_token
  })
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