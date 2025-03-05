
resource "aws_vpc_peering_connection" "peering" {
  count = var.is_peering_required ? 1 : 0
  vpc_id        = module.vpc.vpc_id # requestor VPC
  peer_vpc_id   = data.aws_ssm_parameter.peering_vpc_id.value
  auto_accept = true
  tags = merge(
    var.common_tags,
    {
        Name = "${var.project_name}-${var.env}" #expense-dev
    }
  )
}

resource "aws_route" "public_peering" {
  count = var.is_peering_required ? 1 : 0
  route_table_id            = module.vpc.public_route_table_id
  destination_cidr_block    = data.aws_ssm_parameter.vpc_cider_block.value
  vpc_peering_connection_id = aws_vpc_peering_connection.peering[0].id
}

resource "aws_route" "prod_peering" {
  count = var.is_peering_required ? 1 : 0
  route_table_id            = data.aws_ssm_parameter.public_route_table_id.value
  destination_cidr_block    = module.vpc.vpc_cider_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peering[0].id
  
}

