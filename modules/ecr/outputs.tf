output "repositories" {
  value = aws_ecr_repository.repos[*].repository_url
}
