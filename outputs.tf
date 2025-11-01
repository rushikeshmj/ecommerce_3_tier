output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "rds_endpoint" {
  value = try(module.rds.endpoint, "")
}

output "alb_dns_name" {
  value = try(module.alb.alb_dns, "")
}

output "cloudfront_domain" {
  value = try(module.cloudfront.domain_name, "")
}
