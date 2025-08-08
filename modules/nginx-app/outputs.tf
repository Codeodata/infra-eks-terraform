output "nginx_service_hostname" {
  description = "Hostname del servicio de Nginx"
  value       = try(kubernetes_service.nginx.status[0].load_balancer[0].ingress[0].hostname, "Pendiente")
}

output "nginx_service_name" {
  description = "Nombre del servicio de Nginx"
  value       = kubernetes_service.nginx.metadata[0].name
}

# Puedes añadir este output si necesitas debugging
output "debug_info" {
  description = "Información para debugging"
  value = {
    service_created = kubernetes_service.nginx != null
  }
}