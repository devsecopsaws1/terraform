resource "aws_vpc_peering_connection" "peering_connection" {
  vpc_id        = var.requestor_vpc_id
  peer_vpc_id   = var.peer_vpc_id
  auto_accept   = var.auto_accept
  tags = merge(
    var.common_tags,
    {
        Name = "${var.project_name}-${var.env}" #expense-dev
    }
  )
}


# resource "aws_vpc_peering_connection_accepter" "acceptor" {
#   count = var.auto_accept ? 1 : 0
#   vpc_peering_connection_id = aws_vpc_peering_connection.peering_connection.id
#   auto_accept               = true
# }

resource "aws_route" "requestor_to_peer" {
  route_table_id            = var.route_table_id
  destination_cidr_block    = var.peer_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peering_connection.id
}

resource "aws_route" "peer_to_requestor" {
  count                    = var.auto_accept ? 1 : 0
  route_table_id            = var.dest_route_table_id
  destination_cidr_block    = var.requestor_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peering_connection.id
}
