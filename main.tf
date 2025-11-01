module "vpc" {
  source        = "./modules/vpc"
  project_name  = var.project_name
  environment   = var.environment
}

module "iam" {
  source      = "./modules/iam"
  environment = var.environment
}

module "eks" {
  source        = "./modules/eks"
  vpc_id        = module.vpc.vpc_id
  subnet_ids    = module.vpc.private_subnets
  cluster_name  = "${var.project_name}-${var.environment}-eks"
  project_name  = var.project_name
  environment   = var.environment
}

module "ecr" {
  source        = "./modules/ecr"
  repositories  = [
    "auth", "cart", "order", "product", "payment",
    "inventory", "review", "shipping", "notification",
    "analytics", "api-gateway"
  ]
  project_name  = var.project_name
  environment   = var.environment
}

module "rds" {
  source         = "./modules/rds"
  vpc_id         = module.vpc.vpc_id
  subnet_ids     = module.vpc.database_subnets
  db_name        = "ecommerce_db"
  project_name   = var.project_name
  environment    = var.environment
}

module "redis" {
  source       = "./modules/redis"
  vpc_id       = module.vpc.vpc_id
  subnet_ids   = module.vpc.database_subnets
  project_name = var.project_name
  environment  = var.environment
}

module "s3" {
  source       = "./modules/s3"
  bucket_name  = "${var.project_name}-${var.environment}-assets"
  project_name = var.project_name
  environment  = var.environment
}

module "alb" {
  source       = "./modules/alb"
  vpc_id       = module.vpc.vpc_id
  subnet_ids   = module.vpc.public_subnets
  project_name = var.project_name
  environment  = var.environment
}

module "opensearch" {
  source       = "./modules/opensearch"
  vpc_id       = module.vpc.vpc_id
  project_name = var.project_name
  environment  = var.environment
}
