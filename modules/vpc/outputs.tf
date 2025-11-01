output "vpc_id" {
  value = module.this_vpc.vpc_id
}

output "public_subnets" {
  value = module.this_vpc.public_subnets
}

output "private_subnets" {
  value = module.this_vpc.private_subnets
}

output "database_subnets" {
  value = module.this_vpc.database_subnets
}
