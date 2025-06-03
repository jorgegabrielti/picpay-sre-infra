output "bastion_public_ip" {
  description = "Endereço IP público da instância EC2 Bastion."
  value       = module.ec2_bastion.bastion_public_ip
}

output "bastion_ssh_command" {
  description = "Comando SSH para conectar ao Bastion (pode exigir a chave .pem correspondente se não for via SSM)."
  value       = "ssh -i YOUR_LOCAL_KEY.pem ec2-user@${module.ec2_bastion.bastion_public_ip}"
}

output "bastion_instance_id" {
  description = "ID da instância EC2 Bastion."
  value       = module.ec2_bastion.bastion_instance_id
}