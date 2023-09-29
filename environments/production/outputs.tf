output "gke_endpoint" {
  description = "GKE cluster endpoint"
  value       = module.gke.endpoint
}

output "nginx_service_ip" {
  description = "Public IP for the Nginx service"
  value       = kubernetes_service.nginx_service.load_balancer_ingress[0].ip
}
