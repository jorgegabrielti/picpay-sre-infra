variable "aws_region" {
  description = "Região AWS para criar os recursos de rede."
  type        = string
  default     = "us-east-1"
}

variable "cluster_name" {
  description = "Nome base para os recursos de rede."
  type        = string
  default     = "eks-cluster-lab"
}

variable "vpc_base_cidr" {
  description = "Bloco CIDR base para a VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs_suffix" {
  description = "Lista de sufixos CIDR para as subnets públicas."
  type        = list(string)
  default     = ["0.0/24", "1.0/24", "2.0/24"]
}

variable "private_subnet_cidrs_suffix" {
  description = "Lista de sufixos CIDR para as subnets privadas."
  type        = list(string)
  default     = ["10.0/24", "11.0/24", "12.0/24"]
}

variable "availability_zones_names" {
  description = "Lista de Nomes de Zonas de Disponibilidade para as subnets."
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

locals {
  common_tags = {
    Project     = var.cluster_name
    Provisioner = "Terraform-Network"
  }

  public_subnet_cidrs = [
    for suffix in var.public_subnet_cidrs_suffix : cidrsubnet(var.vpc_base_cidr, 8, tonumber(split(".", suffix)[0]))
  ]

  private_subnet_cidrs = [
    for suffix in var.private_subnet_cidrs_suffix : cidrsubnet(var.vpc_base_cidr, 8, tonumber(split(".", suffix)[0]))
  ]
}
