variable "vpc_id" {
  description = "ID da VPC."
  type        = string
}

variable "igw_id" {
  description = "ID do Internet Gateway para a rota pública."
  type        = string
}

variable "cluster_name" {
  description = "Nome do cluster para usar em tags."
  type        = string
}

variable "public_subnet_cidrs" {
  description = "Lista de blocos CIDR para as subnets públicas."
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "Lista de blocos CIDR para as subnets privadas."
  type        = list(string)
}

variable "availability_zones" {
  description = "Lista de Zonas de Disponibilidade."
  type        = list(string)
}

variable "common_tags" {
  description = "Tags comuns para aplicar aos recursos."
  type        = map(string)
  default     = {}
}
