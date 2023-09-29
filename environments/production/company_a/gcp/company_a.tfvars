region = "us-central1"
vpc_name = "company_a_gke-vpc"
auto_create_subnetworks = false
routing_mode = "REGIONAL"
vpc_description = "VPC for Company A GKE Cluster"
subnet_name = "company_a_gke-subnet"
ip_cidr_range = "10.0.0.0/24"
firewall_name = "company_a_gke-fw-rules"
allowed_protocol = "tcp"
allowed_ports = ["80", "443"]
source_ranges = ["0.0.0.0/0"]
