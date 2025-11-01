module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  vpc_id          = var.vpc_id
  subnet_ids      = var.subnet_ids
  manage_aws_auth = true
  enable_irsa     = true

  eks_managed_node_groups = {
    default = {
      desired_size = var.node_desired
      max_size     = var.node_max
      min_size     = var.node_min
      instance_types = var.instance_types
    }
  }

  tags = {
    Project = var.project_name
    Env     = var.environment
  }
}
