variable "credentials_path" {
  description = "Path to the GCP service account JSON file"
  type        = string
}

variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "us-central1"
}

variable "cluster_name" {
  description = "The name of the GKE cluster"
  type        = string
  default     = "my-cluster"
}

variable "initial_node_count" {
  description = "Initial node count for the GKE cluster"
  type        = number
  default     = 3
}
