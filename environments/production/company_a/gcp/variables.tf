# environments/production/company_a/gcp/variables.tf

variable "region" {
  description = "GCP region"
  type        = string
}

variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "credentials_file" {
  description = "Path to the GCP credentials file"
  type        = string
  sensitive   = true
}
