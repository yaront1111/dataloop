terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
    }
#   backend "gcs" {
#     bucket  = "my-bucket"
#     prefix  = "terraform/state"
   }
 }

provider "google" {
  credentials = file(var.credentials_file)
  project     = var.project_id
  region      = var.region
}
module "network" {
  source = "git::https://github.com/yaront1111/dataloop.git//modules/gcp/networking"

  region                  = var.region
  project_id              = var.project_id
  credentials_file        = var.credentials_file
  vpc_name                = var.vpc_name
  routing_mode            = var.routing_mode
  subnet_name             = var.subnet_name
  ip_cidr_range           = var.ip_cidr_range
  firewall_name           = var.firewall_name
  allowed_protocol        = var.allowed_protocol
}

# GKE Cluster Configuration Module
module "gke_cluster" {
  source = "git::https://github.com/yaront1111/dataloop.git//modules/gcp/compute/gks"

  credentials_path    = var.credentials_file
  project_id          = var.project_id
  region              = var.region
  location            = "us-central1-f"
  cluster_name        = var.cluster_name
  vpc_name            = var.vpc_name
  subnet_name         = var.subnet_name
  initial_node_count  = var.initial_node_count
  office_display_name = var.office_display_name
  office_cidr_block   = var.office_cidr_block
  depends_on = [
    module.network
  ]
# Create namespaces
  namespaces = [
    {
      name = "services"
    },
    {
      name = "monitoring"
    }
  ]
}

provider "helm" {
  kubernetes {
    host                   = "https://${module.gke_cluster.gke_cluster_endpoint}"
    token                  = module.gke_cluster.token
    client_certificate     = base64decode(module.gke_cluster.client_certificate)
    client_key             = base64decode(module.gke_cluster.client_key)
    cluster_ca_certificate = base64decode(module.gke_cluster.gke_cluster_ca_certificate)
  }
}