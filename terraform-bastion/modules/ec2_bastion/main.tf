resource "aws_key_pair" "bastion" {
  key_name   = var.bastion_key_name
  public_key = file(var.local_public_key_path) 

  tags = merge(var.common_tags, {
    Name = var.bastion_key_name
  })
}

# Instância EC2 Bastion
resource "aws_instance" "bastion" {
  ami                         = var.bastion_ami_id
  instance_type               = var.bastion_instance_type
  subnet_id                   = var.bastion_subnet_id
  associate_public_ip_address = true                      # IP público auto-atribuído
  key_name                    = aws_key_pair.bastion.key_name
  vpc_security_group_ids      = [var.bastion_sg_id]

  # Adiciona o user-data para a instalação das ferramentas
  user_data = file("${path.module}/../../bastion_user-data.sh") # Caminho ajustado para o arquivo no diretório raiz

  tags = merge(var.common_tags, {
    Name    = var.instance_name_tag_value
    Purpose = "Bastion"
  })
}