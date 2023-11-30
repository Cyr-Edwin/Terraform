provider "aws" {
    region = var.region
    access_key = var.access_key
    secret_key = var.secret_key
}

# Create random characters
resource "random_string" "string" {
    length = 8
    upper= false
    special = false
}

# Create a S3 bucket
resource "aws_s3_bucket" "bucket" {
    bucket= "my-${random_string.string.result}"
    force_destroy = true
  
}

# Configure S3 bucket for a  website
resource "aws_s3_bucket_website_configuration" "s3_web" {
    bucket = aws_s3_bucket.bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
  
}

# Accessibility of S3
resource "aws_s3_bucket_public_access_block" "public" {
    bucket = aws_s3_bucket.bucket.id
    block_public_acls       = false
    block_public_policy     = false
    ignore_public_acls      = false
    restrict_public_buckets = false

  
}

# Upload files into S3 bucket
resource "aws_s3_object" "file" {
    bucket = aws_s3_bucket.bucket.id
    for_each = fileset("PATH_TO_HTML/", "*")
    key=each.value
    source = "PATH_TO_HTML/${each.value}"
    etag = filemd5("PATH_TO_HTML/${each.value}")
    content_type = "text/html"
}

# Define bucket policy
resource "aws_s3_bucket_policy" "read_access_policy" {
  bucket = aws_s3_bucket.bucket.id
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicReadGetObject",
      "Effect": "Allow",
      "Principal": "*",
      "Action": [
        "s3:GetObject"
      ],
      "Resource": [
        "${aws_s3_bucket.bucket.arn}",
        "${aws_s3_bucket.bucket.arn}/*"
      ]
    }
  ]
}
POLICY
}

