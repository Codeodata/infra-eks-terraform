resource "kubernetes_manifest" "nginx_service_monitor" {
  manifest = {
    apiVersion = "monitoring.coreos.com/v1"
    kind       = "ServiceMonitor"
    metadata = {
      name      = "nginx-monitor"
      namespace = "monitoring"
      labels = {
        release = "kube-prometheus-stack"
      }
    }
    spec = {
      selector = {
        matchLabels = {
          app = "nginx"
        }
      }
      namespaceSelector = {
        matchNames = ["monitoring"]
      }
      endpoints = [
        {
          port     = "metrics"
          interval = "15s"
          path     = "/metrics"
        }
      ]
    }
  }

  depends_on = [
    helm_release.kube_prometheus_stack,
    null_resource.wait_for_crds
  ]
}

resource "kubernetes_manifest" "nginx_service_monitor_default" {
  manifest = {
    apiVersion = "monitoring.coreos.com/v1"
    kind       = "ServiceMonitor"
    metadata = {
      name      = "nginx-monitor-default"
      namespace = "monitoring"   # Se despliega en el namespace de Prometheus
      labels = {
        release = "kube-prometheus-stack"
      }
    }
    spec = {
      selector = {
        matchLabels = {
          app = "nginx"
        }
      }
      namespaceSelector = {
        matchNames = ["default"]   # Selecciona servicios en el namespace "default"
      }
      endpoints = [
        {
          port     = "metrics"
          interval = "15s"
          path     = "/metrics"
        }
      ]
    }
  }

  depends_on = [
    helm_release.kube_prometheus_stack,
    null_resource.wait_for_crds
  ]
}