resource "helm_release" "prometheus-grafana" {
  depends_on = [module.gke_cluster]
  name      = "prometheus-grafana"
  namespace = "monitoring"
  chart     = "kube-prometheus-stack"
  repository = "https://prometheus-community.github.io/helm-charts"

  set {
    name  = "some_key"
    value = "some_value"
  }
}


resource "kubernetes_service" "nginx_lb" {
  depends_on = [module.gke_cluster]
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