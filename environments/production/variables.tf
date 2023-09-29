variable "default_region" {
  description = "The default GCP region for GKE clusters"
  default     = "us-central1"
}

variable "gke_cluster_version" {
  description = "The Kubernetes version for GKE clusters"
  default     = "1.20.8-gke.2100"
}

variable "enable_network_policy" {
  description = "Enable network policies in GKE"
  default     = true
}