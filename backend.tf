terraform {
  backend "s3" {
    bucket         = "skalankar-terraform-state"
    key            = "eks/${var.environment}/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
