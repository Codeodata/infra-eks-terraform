output "cluster_endpoint" {
  description = "Endpoint del clúster EKS"
  value       = module.eks.cluster_endpoint
}

output "cluster_certificate_authority_data" {
  description = "Datos del certificado del clúster"
  value       = module.eks.cluster_certificate_authority_data
}

output "cluster_id" {
  description = "ID del clúster"
  value       = module.eks.cluster_id
}
