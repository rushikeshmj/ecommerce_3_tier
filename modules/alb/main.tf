resource "aws_lb" "alb" {
  name               = "${var.project_name}-${var.environment}-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = var.subnet_ids
  security_groups    = var.security_group_ids
  tags = {
    Project = var.project_name
    Env     = var.environment
  }
}

output "alb_dns" {
  value = aws_lb.alb.dns_name
}
