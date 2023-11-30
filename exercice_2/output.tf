# Display website endpoint
output "endpoint" {
    value=aws_s3_bucket_website_configuration.s3_web.website_endpoint
}

