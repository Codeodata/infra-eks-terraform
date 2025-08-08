output "grafana_release" {
  description = "Release de Grafana desplegada dentro del stack"
  value       = helm_release.kube_prometheus_stack.name
}
output "grafana_service_endpoint" {
  description = "Endpoint del servicio Grafana"
  value       = "Accede a Grafana en http://<LOAD_BALANCER_URL>:80 con usuario 'admin' y contraseña '${var.grafana_admin_password}'"
}

output "prometheus_service_endpoint" {
  description = "Endpoint del servicio Prometheus"
  value       = "Accede a Prometheus en http://<LOAD_BALANCER_URL>:9090"
}
