variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "ap-south-1"
}

variable "aws_profile" {
  description = "AWS CLI profile to use"
  type        = string
  default     = "default"
}

variable "project_name" {
  description = "Project identifier"
  type        = string
  default     = "ecommerce"
}

variable "environment" {
  description = "Environment (dev/staging/prod)"
  type        = string
}
