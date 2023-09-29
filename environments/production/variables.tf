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
variable "credentials_file" {
  description = "Path to the GCP credentials file"
  type        = string
}

variable "project_id" {
  description = "The ID of the GCP project"
  type        = string
}

variable "region" {
  description = "The GCP region to deploy to"
  type        = string
}