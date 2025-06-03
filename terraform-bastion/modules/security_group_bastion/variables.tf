variable "vpc_id" {
  description = "ID da VPC onde o Security Group será criado."
  type        = string
}

variable "sg_name" {
  description = "Nome do Security Group."
  type        = string
}

variable "allowed_ssh_ip" {
  description = "Bloco CIDR do IP permitido para acesso SSH. Ex: 'YOUR_IP/32'."
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