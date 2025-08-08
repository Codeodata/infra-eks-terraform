variable "vpc_name" {
  description = "Nombre de la VPC"
  type        = string
  default     = "eks-vpc"
}

variable "cidr" {
  description = "CIDR de la VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "azs" {
  description = "Lista de zonas de disponibilidad a utilizar"
  type        = list(string)
}

variable "public_subnets" {
  description = "Lista de subredes públicas"
  type        = list(string)
}

variable "private_subnets" {
  description = "Lista de subredes privadas"
  type        = list(string)
}

variable "enable_nat_gateway" {
  description = "Habilita NAT Gateway para las subredes privadas"
  type        = bool
  default     = true
}

variable "single_nat_gateway" {
  description = "Utiliza un único NAT Gateway"
  type        = bool
  default     = true
}
