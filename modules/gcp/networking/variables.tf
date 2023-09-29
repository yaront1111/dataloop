variable "region" {
  description = "GCP region"
  default     = "us-central1"
}

variable "vpc_name" {
  description = "Name of the VPC"
  default     = "gke-vpc"
}

variable "auto_create_subnetworks" {
  description = "Auto-create subnetworks for the VPC"
  default     = false
}

variable "routing_mode" {
  description = "Network routing mode"
  default     = "REGIONAL"
}

variable "vpc_description" {
  description = "VPC description"
  default     = "VPC for GKE Cluster"
}

variable "subnet_name" {
  description = "Subnet name"
  default     = "gke-subnet"
}

variable "ip_cidr_range" {
  description = "CIDR range for the subnet"
  default     = "10.0.0.0/24"
}

variable "firewall_name" {
  description = "Name of the firewall rules"
  default     = "gke-fw-rules"
}

variable "allowed_protocol" {
  description = "Allowed protocol for firewall rules"
  default     = "tcp"
}

variable "allowed_ports" {
  description = "Allowed ports for firewall rules"
  default     = ["80", "443"]
}

variable "source_ranges" {
  description = "Allowed source ranges for firewall rules"
  default     = ["0.0.0.0/0"]
}
