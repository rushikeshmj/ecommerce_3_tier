resource "aws_s3_bucket" "frontend" {
  bucket = var.bucket_name

  tags = {
    Project = var.project_name
    Env     = var.environment
  }
}

# Define bucket ownership & ACL settings (replaces `acl`)
resource "aws_s3_bucket_ownership_controls" "frontend" {
  bucket = aws_s3_bucket.frontend.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "frontend" {
  bucket = aws_s3_bucket.frontend.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Explicitly set public-read ACL
resource "aws_s3_bucket_acl" "frontend" {
  depends_on = [
    aws_s3_bucket_ownership_controls.frontend,
    aws_s3_bucket_public_access_block.frontend
  ]

  bucket = aws_s3_bucket.frontend.id
  acl    = "public-read"
}

# Configure static website hosting (replaces `website` block)
resource "aws_s3_bucket_website_configuration" "frontend" {
  bucket = aws_s3_bucket.frontend.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}
