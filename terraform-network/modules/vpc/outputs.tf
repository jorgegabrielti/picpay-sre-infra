output "vpc_id" {
  description = "O ID da VPC criada."
  value       = aws_vpc.module_vpc.id
}

output "vpc_cidr_block" {
  description = "O bloco CIDR da VPC criada."
  value       = aws_vpc.module_vpc.cidr_block
}
