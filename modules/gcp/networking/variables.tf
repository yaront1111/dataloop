# GCP region where resources will be created
variable "region" {
  description = "GCP region where resources will be created"
  type        = string
}

# The ID of the GCP project where resources will be created
variable "project_id" {
  description = "The ID of the GCP project"
  type        = string
}

# Path to the GCP credentials file
variable "credentials_file" {
  description = "Path to the GCP credentials file"
  type        = string
  sensitive   = true
}

# Name of the VPC to be created
variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

# Whether to auto-create subnetworks for the VPC
variable "auto_create_subnetworks" {
  description = "Auto-create subnetworks for the VPC"
  type        = bool
  default     = false
}

# Network routing mode for the VPC
variable "routing_mode" {
  description = "Network routing mode for the VPC"
  type        = string
  default     = "REGIONAL"
}

# Description to be added to the VPC
variable "vpc_description" {
  description = "VPC description"
  type        = string
  default     = "VPC for GKE Cluster"
}

# Name of the subnet to be created
variable "subnet_name" {
  description = "Name of the subnet"
  type        = string
}

# CIDR range for the subnet
variable "ip_cidr_range" {
  description = "CIDR range for the subnet"
  type        = string
}

# Name of the firewall rules to be created
variable "firewall_name" {
  description = "Name of the firewall rules"
  type        = string
}

# Protocol allowed by the firewall rules
variable "allowed_protocol" {
  description = "Protocol allowed by the firewall rules"
  type        = string
  default     = "tcp"
}

# Ports allowed by the firewall rules
variable "allowed_ports" {
  description = "Ports allowed by the firewall rules"
  type        = list(string)
  default     = ["80", "443", "6443", "10250", "10255", "30000-32767"]
}

# Source ranges for the firewall rules
variable "source_ranges" {
  description = "Source ranges for the firewall rules"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
