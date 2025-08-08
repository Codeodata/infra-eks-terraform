# Primero define completamente el deployment
resource "kubernetes_deployment" "nginx" {
  metadata {
    name = "nginx-deployment"
    labels = {
      app = "nginx"
    }
  }
  spec {
    replicas = var.replicas
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
        annotations = {
          "prometheus.io/scrape" = "true"
          "prometheus.io/port"   = "9113"
          "prometheus.io/path"   = "/metrics"
        }
      }
      spec {
        container {
          name  = "nginx"
          image = "nginx:latest"
          port {
            container_port = 80
            name           = "http"
          }
          volume_mount {
            name       = "nginx-conf"
            mount_path = "/etc/nginx/conf.d"
          }
        }
        
        # Añadir el contenedor del exporter
        container {
          name  = "nginx-exporter"
          image = "nginx/nginx-prometheus-exporter:0.10.0"
          args  = ["-nginx.scrape-uri=http://localhost:80/stub_status"]
          port {
            container_port = 9113
            name           = "metrics"
          }
        }
        
        # Volumen para configuración personalizada de NGINX
        volume {
          name = "nginx-conf"
          config_map {
            name = kubernetes_config_map.nginx_config.metadata[0].name
          }
        }
      }
    }
  }
}

# ConfigMap para habilitar stub_status en NGINX
resource "kubernetes_config_map" "nginx_config" {
  metadata {
    name = "nginx-config"
    labels = {
      app = "nginx"
    }
  }

  data = {
    "default.conf" = <<-EOF
      server {
        listen 80;
        server_name localhost;

        location / {
          root   /usr/share/nginx/html;
          index  index.html index.htm;
        }

        # Configuración para stub_status
        location /stub_status {
          stub_status on;
          access_log off;
          allow 127.0.0.1; # Solo permitir acceso desde localhost (el exporter)
          deny all;
        }
      }
    EOF
  }
}

# Luego define el servicio haciendo referencia al deployment
resource "kubernetes_service" "nginx" {
  metadata {
    name = "nginx-service"
    labels = {
      app = "nginx"
    }
  }
  spec {
    selector = {
      app = "nginx"  # Simplificado para evitar referencias circulares
    }
    port {
      name        = "http"
      port        = 80
      target_port = 80
    }
    # Puerto para las métricas
    port {
      name        = "metrics"
      port        = 9113
      target_port = 9113
    }
    type = "LoadBalancer"
  }
}