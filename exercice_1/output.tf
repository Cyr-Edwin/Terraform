output "main_route_table_id" {
    value = aws_vpc.vpc.main_route_table_id
}

output "data" {
    value = data.aws_availability_zones.available 
}


output "availability_zone" {
    value = aws_subnet.subnet
  
}