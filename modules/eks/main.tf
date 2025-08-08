module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.35.0"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  cluster_endpoint_public_access = true
  enable_cluster_creator_admin_permissions = true

  vpc_id                = var.vpc_id
  subnet_ids            = var.private_subnets  # Cambiado de 'subnets' a 'subnet_ids'

  # Configuración de nodos gestionados
  eks_managed_node_groups = {  # Cambiado de 'managed_node_groups' a 'eks_managed_node_groups'
    eks_nodes = {
      instance_types   = [var.node_instance_type]  # Cambiado de 'instance_type' a 'instance_types' (ahora es una lista)
      desired_size     = var.node_desired_capacity  # Cambiado de 'desired_capacity' a 'desired_size'
      min_size         = var.node_min_capacity      # Cambiado de 'min_capacity' a 'min_size'
      max_size         = var.node_max_capacity      # Cambiado de 'max_capacity' a 'max_size'
      # Otros parámetros opcionales aquí
    }
  }
}