output "igw_id" {
  description = "O ID do Internet Gateway criado."
  value       = aws_internet_gateway.module_igw.id
}
