resource "aws_internet_gateway" "module_igw" {
  vpc_id = var.vpc_id

  tags = merge(var.common_tags, {
    # Nome do IGW conforme script.
    Name = "${var.cluster_name}-igw"
  })
}
