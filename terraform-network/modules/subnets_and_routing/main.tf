# Subnets Públicas
resource "aws_subnet" "public" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = var.vpc_id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true # Conforme script (modify-subnet-attribute --map-public-ip-on-launch)

  tags = merge(var.common_tags, {
    # Nome das subnets públicas conforme script.
    Name = "${var.cluster_name}-eks-public-${count.index + 1}"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                   = "1"
    "kubernetes.io/role/internal-elb"       = "1"
    "karpenter.sh/discovery"                   = var.cluster_name
  })
}

# Subnets Privadas
resource "aws_subnet" "private" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = var.vpc_id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]
  # map_public_ip_on_launch é false por padrão, o que é correto para subnets privadas.

  tags = merge(var.common_tags, {
    # Nome das subnets privadas conforme script.
    Name = "${var.cluster_name}-eks-private-${count.index + 1}"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                   = "1"
    "kubernetes.io/role/internal-elb"       = "1"
    "karpenter.sh/discovery"                   = var.cluster_name
  })
}

# Route Table Pública
resource "aws_route_table" "public" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0" # Rota padrão para a internet
    gateway_id = var.igw_id  # Através do Internet Gateway
  }

  tags = merge(var.common_tags, {
    # Nome da Route Table pública conforme script.
    Name = "${var.cluster_name}-public-rt"
  })
}

resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# Route Table Privada
resource "aws_route_table" "private" {
  vpc_id = var.vpc_id
  # Nenhuma rota padrão para IGW. Para acesso à internet, um NAT Gateway seria necessário.

  tags = merge(var.common_tags, {
    # Nome da Route Table privada conforme script.
    Name = "${var.cluster_name}-private-rt"
  })
}

resource "aws_route_table_association" "private" {
  count          = length(aws_subnet.private)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}
