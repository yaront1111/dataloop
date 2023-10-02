variable "credentials_path" {
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
  default = "us-central1-f"
}

variable "cluster_name" {
  description = "The name of the GKE cluster"
  type        = string
}

variable "initial_node_count" {
  description = "Initial node count for the GKE cluster"
  type        = number
}

variable "office_display_name" {
  description = "Display name for authorized networks"
  type        = string
}

variable "office_cidr_block" {
  description = "CIDR block for authorized networks"
  type        = string
}

variable "logging_service" {
  description = "Logging service for GKE"
  type        = string
  default     = "logging.googleapis.com/kubernetes"
}

variable "monitoring_service" {
  description = "Monitoring service for GKE"
  type        = string
  default     = "monitoring.googleapis.com/kubernetes"
}

variable "network_policy_enabled" {
  description = "Is network policy enabled?"
  type        = bool
  default     = true
}

variable "network_policy_provider" {
  description = "Provider for network policies"
  type        = string
  default     = "CALICO"
}

variable "maintenance_start_time" {
  description = "Start time for daily maintenance window"
  type        = string
  default     = "03:00"
}
variable "namespaces" {
  description = "List of namespaces to create"
  type        = list(object({ name = string }))
  default     = []
}
