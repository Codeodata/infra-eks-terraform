resource "kubernetes_manifest" "prometheus_rule" {
  manifest = {
    apiVersion = "monitoring.coreos.com/v1"
    kind       = "PrometheusRule"
    metadata = {
      name      = "nginx-alerts"
      namespace = "monitoring"
      labels = {
        release = "kube-prometheus-stack"
      }
    }
    spec = {
      groups = [
        {
          name = "nginx.rules"
          rules = [
            {
              alert = "NginxDown"
              expr  = "absent(up{job=\"nginx-exporter\"})"
              for   = "1m"
              labels = {
                severity = "critical"
              }
              annotations = {
                summary     = "Nginx instance is down"
                description = "Nginx has been down for more than 1 minute"
              }
            },
            {
              alert = "NginxHighRequestRate"
              expr  = "sum(rate(nginx_http_requests_total{job=\"nginx-exporter\"}[5m])) by (instance) > 100"
              for   = "5m"
              labels = {
                severity = "warning"
              }
              annotations = {
                summary     = "High Nginx request rate"
                description = "Nginx is receiving a high number of requests"
              }
            }
          ]
        }
      ]
    }
  }

    depends_on = [
    helm_release.kube_prometheus_stack,
    null_resource.wait_for_crds
    ]
}