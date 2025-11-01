module "this_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  name    = "${var.project_name}-${var.environment}-vpc"
  cidr    = var.cidr

  azs             = var.azs
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  database_subnets = var.database_subnets

  enable_nat_gateway = true
  single_nat_gateway = true
}
