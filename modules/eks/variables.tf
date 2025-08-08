variable "cluster_name" {
  description = "Nombre del clúster EKS"
  type        = string
  default     = "eks-demo-cluster"
}

variable "cluster_version" {
  description = "Versión de Kubernetes para el clúster"
  type        = string
  default     = "1.21"
}

variable "vpc_id" {
  description = "ID de la VPC donde desplegar el clúster"
  type        = string
}

variable "private_subnets" {
  description = "Subredes privadas para el clúster"
  type        = list(string)
}

variable "node_instance_type" {
  description = "Tipo de instancia para los nodos"
  type        = string
  default     = "t3.medium"
}

variable "node_desired_capacity" {
  description = "Cantidad deseada de nodos"
  type        = number
  default     = 2
}

variable "node_min_capacity" {
  description = "Cantidad mínima de nodos"
  type        = number
  default     = 1
}

variable "node_max_capacity" {
  description = "Cantidad máxima de nodos"
  type        = number
  default     = 3
}

variable "managed_node_groups" {
  description = "Definición de los Managed Node Groups para el clúster EKS"
  type        = any
  default     = {}
}

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
