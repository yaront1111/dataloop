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
  auto_create_subnetworks = var.auto_create_subnetworks
  routing_mode            = var.routing_mode
  vpc_description         = var.vpc_description
  subnet_name             = var.subnet_name
  ip_cidr_range           = var.ip_cidr_range
  firewall_name           = var.firewall_name
  allowed_protocol        = var.allowed_protocol
  allowed_ports           = var.allowed_ports
  source_ranges           = var.source_ranges
}