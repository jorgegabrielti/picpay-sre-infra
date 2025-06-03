variable "vpc_id" {
  description = "ID da VPC onde o Internet Gateway será anexado."
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
