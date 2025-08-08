variable "manage_aws_auth_configmap" {
  description = "Determina si se debe gestionar el ConfigMap aws-auth"
  type        = bool
  default     = true
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

variable "aws_auth_roles" {
  description = "Lista de roles de IAM para añadir al ConfigMap aws-auth"
  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))
  default = []
}

variable "aws_auth_accounts" {
  description = "Lista de cuentas AWS para añadir al ConfigMap aws-auth"
  type        = list(string)
  default     = []
}