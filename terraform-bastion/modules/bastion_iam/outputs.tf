output "iam_instance_profile_name" {
  description = "O nome do IAM Instance Profile criado para o Bastion."
  value       = aws_iam_instance_profile.bastion_profile.name
}

output "iam_role_arn" {
  description = "O ARN do IAM Role criado para o Bastion."
  value       = aws_iam_role.bastion_role.arn
}