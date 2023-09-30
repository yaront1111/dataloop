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

module "gke_cluster" {
  source = "./gke_module"

  credentials_path   = var.credentials_file
  project_id         = var.project_id
  region             = var.default_region
  cluster_name       = "my-gke-cluster"
  initial_node_count = 1

  network_name       = module.network.vpc_name
  subnet_name        = module.network.subnet_name
}