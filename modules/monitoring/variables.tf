variable "grafana_admin_password" {
  description = "Contraseña del usuario admin de Grafana"
  type        = string
  default     = "admin123"
}

variable "prometheus_chart_version" {
  description = "Versión del chart kube-prometheus-stack"
  type        = string
  default     = "45.8.0"
}
