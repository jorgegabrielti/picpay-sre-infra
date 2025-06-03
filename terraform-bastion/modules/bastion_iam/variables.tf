variable "cluster_name" {
  description = "Nome do cluster para usar em tags e nomes de recursos IAM."
  type        = string
}

variable "common_tags" {
  description = "Tags comuns para aplicar aos recursos."
  type        = map(string)
  default     = {}
}