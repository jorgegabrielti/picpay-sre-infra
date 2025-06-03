output "bastion_instance_id" {
  description = "ID da instância EC2 Bastion."
  value       = aws_instance.bastion.id
}

output "bastion_public_ip" {
  description = "Endereço IP público da instância EC2 Bastion."
  value       = aws_instance.bastion.public_ip
}