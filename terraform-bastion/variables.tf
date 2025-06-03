variable "aws_region" {
  description = "Região AWS para criar os recursos do bastion."
  type        = string
  default     = "us-east-1"
}

variable "cluster_name" {
  description = "Nome base para os recursos do bastion."
  type        = string
  default     = "picpay-sre-senior-cards"
}

# Variáveis que virão como outputs do Projeto 1
variable "existing_vpc_id" {
  description = "ID da VPC existente (do Projeto 1)."
  type        = string
}

variable "existing_public_subnet_ids" {
  description = "Lista de IDs das subnets públicas existentes (do Projeto 1)."
  type        = list(string)
}

variable "bastion_instance_type" {
  description = "Tipo de instância para o Bastion Host."
  type        = string
  default     = "t2.micro"
}

variable "bastion_ami_id_value" {
  description = "ID da AMI para o Bastion Host. Verifique a validade para a região us-east-1."
  type        = string
  default     = "ami-0953476d60561c955" # Amazon Linux 2 AMI (SSM Agent pré-instalado)
}

variable "bastion_ssh_key_name_value" {
  description = "Nome do par de chaves SSH para o Bastion Host a ser criado na AWS."
  type        = string
  default     = "eks-bastion-public"
}

variable "my_allowed_ssh_ip" {
  description = "Seu endereço IP público para permitir acesso SSH ao bastion. Ex: 'YOUR_IP/32'."
  type        = string
  # Este valor DEVE ser fornecido pelo usuário no arquivo terraform.tfvars
}

variable "iam_instance_profile_name" {
  description = "The name of the IAM instance profile to attach to the bastion host"
  type        = string
}


locals {
  common_tags = {
    Project     = var.cluster_name
    Provisioner = "Terraform-Bastion"
  }
}