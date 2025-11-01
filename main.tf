module "vpc" {
  source = "./modules/vpc"
  project_name = var.project_name
  environment  = var.environment
}

module "iam" {
  source = "./modules/iam"
  environment = var.environment
}

module "eks" {
  source        = "./modules/eks"
  vpc_id        = module.vpc.vpc_id
  subnet_ids    = module.vpc.private_subnets
  cluster_name  = "${var.project_name}-${var.environment}"
}

module "ecr" {
  source = "./modules/ecr"
  repositories = ["auth", "cart", "order", "product", "payment", "inventory", "review", "shipping", "notification", "analytics", "api-gateway"]
}

module "rds" {
  source         = "./modules/rds"
  vpc_id         = module.vpc.vpc_id
  subnet_ids     = module.vpc.database_subnets
  db_name        = "ecommerce_db"
  environment    = var.environment
}

module "redis" {
  source     = "./modules/redis"
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.database_subnets
}

module "s3" {
  source      = "./modules/s3"
  bucket_name = "${var.project_name}-${var.environment}-assets"
}

module "alb" {
  source     = "./modules/alb"
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.public_subnets
}

module "opensearch" {
  source = "./modules/opensearch"
  vpc_id = module.vpc.vpc_id
}
