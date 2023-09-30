region = "us-central1"
vpc_name = "company-a-gke-vpc"
auto_create_subnetworks = false
routing_mode = "REGIONAL"
subnet_name = "company-a-gke-subnet"
ip_cidr_range = "10.0.0.0/24"
firewall_name = "company-a-gke-fw-rules"
allowed_protocol = "tcp"
allowed_ports = ["80", "443"]
cluster_name = "yaron-cluster"
initial_node_count = 1
office_cidr_block = "10.0.0.0/24"
office_display_name = "office"