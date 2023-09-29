provider "google" {
  credentials = file(var.credentials_file)
  project     = var.project_id
  region      = var.region
}

module "network" {
  source  = "git::https://github.com/yaront1111/dataloop.git/modules/gcp/networking"
  project = var.project_id
  region  = var.region
  // Additional variables and settings specific to networking
}