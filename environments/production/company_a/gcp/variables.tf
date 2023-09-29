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
variable "subnet_name" {
  description = "The name of the subnet."
  type        = string
}

variable "ip_cidr_range" {
  description = "The CIDR range for the subnet."
  type        = string
}

variable "vpc_name" {
  description = "The name of the VPC."
  type        = string
}

variable "firewall_name" {
  description = "The name of the firewall."
  type        = string
}
variable "allowed_protocol" {
  description = "Allowed protocol for the resource."
  type        = string
}

variable "routing_mode" {
  description = "Routing mode for the resource."
  type        = string
}