module "aws_auth" {
  source  = "terraform-aws-modules/eks/aws//modules/aws-auth"
  version = "20.35.0"
  
  manage_aws_auth_configmap = var.manage_aws_auth_configmap
  aws_auth_users            = var.aws_auth_users
  aws_auth_roles            = var.aws_auth_roles
  aws_auth_accounts         = var.aws_auth_accounts
}