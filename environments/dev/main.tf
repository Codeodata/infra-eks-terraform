// Llamada al módulo VPC
module "vpc" {
  source          = "../../modules/vpc"
  vpc_name        = "eks-vpc-dev"
  cidr            = "10.0.0.0/16"
  azs             = var.availability_zones
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
}

// Configurar el aws-auth para el acceso al clúster
module "eks_aws_auth" {
  source = "../../modules/eks/aws-auth"

  manage_aws_auth_configmap = true
  aws_auth_users = [
    {
      userarn  = "arn:aws:iam::083904820942:user/sbertola" # Reemplaza con tu ARN correcto
      username = "sbertola"
      groups   = ["system:masters"]
    }
  ]
}

// Llamada al módulo EKS (se usan las subredes privadas para el clúster)
module "eks" {
  source          = "../../modules/eks"
  cluster_name    = var.cluster_name
  cluster_version = "1.29"
  vpc_id          = module.vpc.vpc_id

  // Se mapea la variable desde el módulo VPC a la variable privada del clúster
  private_subnets = module.vpc.private_subnets

  managed_node_groups = {
    eks_nodes = {
      instance_type    = "t3.medium"
      desired_capacity = 2
      min_capacity     = 1
      max_capacity     = 3
    }
  }
}

// Configuración del provider Kubernetes (usando outputs del clúster EKS)
provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

data "aws_eks_cluster" "cluster" {
  name = var.cluster_name
}

data "aws_eks_cluster_auth" "cluster" {
  name = var.cluster_name
}

// Desplegar la aplicación Nginx
module "nginx_app" {
  source   = "../../modules/nginx-app"
  replicas = 2
}

// Configuración del provider Helm (también usando los outputs del clúster)
provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    token                  = data.aws_eks_cluster_auth.cluster.token
  }
}

// Desplegar monitoreo con Prometheus y Grafana
module "monitoring" {
  source                   = "../../modules/monitoring"
  grafana_admin_password   = "admin123"
  prometheus_chart_version = "45.8.0"
}
