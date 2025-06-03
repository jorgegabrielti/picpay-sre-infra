resource "aws_iam_role" "bastion_role" {
  name               = "${var.cluster_name}-bastion-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      },
    ]
  })

  tags = merge(var.common_tags, {
    Name    = "${var.cluster_name}-bastion-role"
    Purpose = "Bastion-IAM-Role"
  })
}

resource "aws_iam_role_policy_attachment" "admin_access" {
  role       = aws_iam_role.bastion_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

#resource "aws_iam_role_policy_attachment" "ssm_managed_instance_core" {
#  role       = aws_iam_role.bastion_role.name
#  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
#}

#resource "aws_iam_role_policy_attachment" "eks_policy_attachment" {
#  role       = aws_iam_role.bastion_role.name
#  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy" 
#}

resource "aws_iam_instance_profile" "bastion_profile" {
  name = "${var.cluster_name}-bastion-profile"
  role = aws_iam_role.bastion_role.name

  tags = merge(var.common_tags, {
    Name    = "${var.cluster_name}-bastion-profile"
    Purpose = "Bastion-IAM-Profile"
  })
}