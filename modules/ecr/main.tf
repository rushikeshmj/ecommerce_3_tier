resource "aws_ecr_repository" "repos" {
  for_each = toset(var.repositories)
  name     = each.value

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Project = var.project_name
    Env     = var.environment
  }
}
