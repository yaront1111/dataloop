terraform {
  backend "gcs" {
    bucket  = "my-bucket"
    prefix  = "terraform/state"
  }
}

provider "google" {
  version     = "~> 3.5"
  credentials = var.credentials_file
  project     = var.project_id
  region      = var.region
}

module "network" {
  source = "git::https://github.com/yaront1111/dataloop.git//modules/gcp/networking"
  region  = var.region
}