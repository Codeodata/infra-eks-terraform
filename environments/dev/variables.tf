variable "aws_auth_users" {
  description = "Lista de usuarios de IAM para añadir al ConfigMap aws-auth"
  type = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))
  default = []
}

variable "manage_aws_auth_configmap" {
  description = "Si se debe gestionar el ConfigMap aws-auth"
  type        = bool
  default     = true
}

variable "aws_region" {
  description = "Región de AWS a utilizar"
  type        = string
  default     = "us-east-1"
}

variable "availability_zones" {
  description = "AZs a utilizar"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "public_subnets" {
  description = "CIDRs para subredes públicas"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "private_subnets" {
  description = "CIDRs para subredes privadas"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

# Variables específicas de EKS
variable "cluster_name" {
  description = "Nombre del clúster EKS"
  type        = string
  default     = "eks-demo-cluster"
}

# Variables para Nginx y Monitoring pueden ser asignadas aquí o usar valores por defecto en cada módulo
