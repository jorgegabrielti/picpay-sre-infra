resource "aws_security_group" "bastion_sg" {
  name        = var.sg_name
  description = "Security Group para o Bastion Host - Acesso SSH"
  vpc_id      = var.vpc_id

  # Regra para permitir SSH (porta 22) do seu IP específico
  ingress {
    description = "SSH from allowed IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    #cidr_blocks = [var.allowed_ssh_ip] # Seu IP público
    ipv6_cidr_blocks = [var.allowed_ssh_ip]
  }

  # Regra de saída (permite todo o tráfego de saída)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Todos os protocolos
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.common_tags, {
    Name    = var.sg_name
    Purpose = "Bastion-SG"
  })
}