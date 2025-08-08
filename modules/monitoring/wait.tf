resource "null_resource" "wait_for_crds" {
  depends_on = [helm_release.kube_prometheus_stack]

  provisioner "local-exec" {
    command = "sleep 45"  # Esperar 45 segundos para que los CRDs se instalen
  }
}