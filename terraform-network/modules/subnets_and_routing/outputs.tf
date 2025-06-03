output "public_subnet_ids" {
  description = "Lista de IDs das subnets públicas."
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "Lista de IDs das subnets privadas."
  value       = aws_subnet.private[*].id
}

output "public_route_table_id" {
  description = "ID da Route Table pública."
  value       = aws_route_table.public.id
}

output "private_route_table_id" {
  description = "ID da Route Table privada."
  value       = aws_route_table.private.id
}
