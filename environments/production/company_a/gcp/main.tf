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
  region              = var.default_region
  cluster_name        = "my-gke-cluster"
  initial_node_count  = 1

  office_cidr_block   = "192.168.0.0/16"
  office_display_name = "office-network"

  network             = module.network.vpc_name
  subnetwork          = module.network.subnet_name

  depends_on = [
    module.network
  ]
}