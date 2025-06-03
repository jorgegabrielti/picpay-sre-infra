output "security_group_id" {
  description = "ID do Security Group do Bastion Host."
  value       = aws_security_group.bastion_sg.id
}