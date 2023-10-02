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
  cluster_name        = var.cluster_name
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

resource "google_container_node_pool" "primary_nodes" {
  name       = "my-node-pool"
  cluster    = module.gke_cluster.name
  location   = module.gke_cluster.location
  node_count = 1

  node_config {
    machine_type = "f1-micro"
    metadata = {
      disable-legacy-endpoints = "true"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}

provider "kubernetes" {
  config_path = "${module.gke_cluster.kubeconfig}"
}
resource "kubernetes_deployment" "nginx" {
  depends_on = [module.gke_cluster]
  metadata {
    name      = "nginx"
    namespace = "services"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "nginx"
      }
    }

    template {
      metadata {
        labels = {
          app = "nginx"
        }
      }

      spec {
        container {
          name  = "nginx"
          image = "nginx:latest"

          port {
            container_port = 80
          }
        }
      }
    }
  }
}

resource "helm_release" "prometheus_grafana" {
  depends_on = [module.gke_cluster]
  name      = "prometheus_grafana"
  namespace = "monitoring"
  chart     = "prometheus-community/kube-prometheus-stack"
  repository = "https://prometheus-community.github.io/helm-charts"

  set {
    name  = "some_key"
    value = "some_value"
  }
}


resource "kubernetes_service" "nginx_lb" {
  metadata {
    name = "nginx-lb"
    namespace = "services"
  }

  spec {
    selector = {
      app = "nginx"
    }

    type = "LoadBalancer"

    port {
      port = 80
      target_port = 80
    }
  }
}

resource "kubernetes_service" "grafana_lb" {
  metadata {
    name = "grafana-lb"
    namespace = "monitoring"
  }

  spec {
    selector = {
      app = "grafana"
    }

    type = "LoadBalancer"

    port {
      port = 3000
      target_port = 3000
    }
  }
}