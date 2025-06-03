variable "bastion_ami_id" {
  description = "ID da AMI para a instância Bastion."
  type        = string
}

variable "bastion_instance_type" {
  description = "Tipo de instância para o Bastion."
  type        = string
}

variable "bastion_subnet_id" {
  description = "ID da Subnet (pública) para o Bastion."
  type        = string
}

variable "bastion_key_name" {
  description = "Nome do par de chaves SSH a ser criado/usado na AWS."
  type        = string
}

variable "bastion_sg_id" {
  description = "ID do Security Group para o Bastion."
  type        = string
}

variable "cluster_name" {
  description = "Nome do cluster para usar em tags."
  type        = string
}

variable "instance_name_tag_value" {
  description = "Valor para a tag 'Name' da instância EC2."
  type        = string
}

variable "common_tags" {
  description = "Tags comuns para aplicar aos recursos."
  type        = map(string)
  default     = {}
}

variable "local_public_key_path" {
  description = "Caminho absoluto para o arquivo da chave pública SSH local."
  type        = string
}