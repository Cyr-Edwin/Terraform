provider "aws" {
    region = var.region
    access_key = var.access_key
    secret_key = var.secret_key
}

# Define VPC
resource "aws_vpc" "vpc" {
    cidr_block = "10.0.0.0/16"
}

# Define Internet Gateway and attach it to a VPC
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc.id
}

# Add route as "0.0.0.0/0" and destination as Internet Gateway
resource "aws_route" "route" {
    route_table_id = aws_vpc.vpc.main_route_table_id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  
}

# Check all availability zone
data "aws_availability_zones" "available" {}

# Create a Subnet in all availability zones
resource "aws_subnet" "subnet" {
  count = length(data.aws_availability_zones.available.names)
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.0.${count.index}.0/24"
  map_public_ip_on_launch = true
  availability_zone = element(data.aws_availability_zones.available.names , count.index)
}