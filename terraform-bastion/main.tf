module "security_group_bastion" {
  source = "./modules/security_group_bastion"

  vpc_id         = var.existing_vpc_id
  sg_name        = "${var.cluster_name}-bastion-sg"
  allowed_ssh_ip = var.my_allowed_ssh_ip # 
  cluster_name   = var.cluster_name
  common_tags    = local.common_tags
}

module "ec2_bastion" {
  source = "./modules/ec2_bastion"

  bastion_ami_id          = var.bastion_ami_id_value
  bastion_instance_type   = var.bastion_instance_type
  bastion_subnet_id       = var.existing_public_subnet_ids[0]
  bastion_key_name        = var.bastion_ssh_key_name_value
  bastion_sg_id           = module.security_group_bastion.security_group_id
  cluster_name            = var.cluster_name
  common_tags             = local.common_tags
  instance_name_tag_value = "eks-bastion-public"
  local_public_key_path   = "~/.ssh/eks-bastion-ssh-key.pub"
}
