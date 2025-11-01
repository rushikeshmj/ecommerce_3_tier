resource "aws_elasticache_subnet_group" "redis_subnet" {
  name       = "${var.project_name}-${var.environment}-redis-subnet"
  subnet_ids = var.subnet_ids
}

resource "aws_elasticache_cluster" "redis" {
  cluster_id        = "${var.project_name}-${var.environment}-redis"
  engine            = "redis"
  node_type         = var.node_type
  num_cache_nodes   = var.num_cache_nodes
  subnet_group_name = aws_elasticache_subnet_group.redis_subnet.name
}
