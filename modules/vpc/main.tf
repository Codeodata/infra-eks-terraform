module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.5.0"  # Actualiza a la versión más reciente estable

  name = var.vpc_name
  cidr = var.cidr

  azs             = var.azs
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets

  enable_nat_gateway = var.enable_nat_gateway
  single_nat_gateway = var.single_nat_gateway

  tags = {
    Environment = "dev"
  }
}