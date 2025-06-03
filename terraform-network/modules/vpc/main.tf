resource "aws_vpc" "module_vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge(var.common_tags, {
    Name                                       = "project-${var.cluster_name}"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                   = "1"
    "kubernetes.io/role/internal-elb"            = "1"
  })
}
