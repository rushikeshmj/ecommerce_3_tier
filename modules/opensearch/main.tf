resource "aws_opensearch_domain" "logs" {
  domain_name = "${var.project_name}-${var.environment}-logs"
  engine_version = "OpenSearch_2.13"
  cluster_config {
    instance_type = var.instance_type
    instance_count = var.instance_count
  }
  ebs_options {
    ebs_enabled = true
    volume_size = var.volume_size
  }

  tags = {
    Project = var.project_name
    Env     = var.environment
  }
}
