module "vpc" {
  source = "./modules/vpc"

  vpc_cidr_block = var.vpc_base_cidr
  cluster_name   = var.cluster_name
  common_tags    = local.common_tags
}

module "internet_gateway" {
  source = "./modules/internet_gateway"

  vpc_id       = module.vpc.vpc_id
  cluster_name = var.cluster_name
  common_tags  = local.common_tags

  depends_on = [module.vpc]
}

module "subnets_and_routing" {
  source = "./modules/subnets_and_routing"

  vpc_id               = module.vpc.vpc_id
  igw_id               = module.internet_gateway.igw_id
  cluster_name         = var.cluster_name
  public_subnet_cidrs  = local.public_subnet_cidrs
  private_subnet_cidrs = local.private_subnet_cidrs
  availability_zones   = var.availability_zones_names
  common_tags          = local.common_tags

  depends_on = [module.internet_gateway]
}