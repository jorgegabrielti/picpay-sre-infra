variable "vpc_cidr_block" {
  description = "Bloco CIDR para a VPC."
  type        = string
}

variable "cluster_name" {
  description = "Nome do cluster para usar em tags."
  type        = string
}

variable "common_tags" {
  description = "Tags comuns para aplicar aos recursos."
  type        = map(string)
  default     = {}
}
