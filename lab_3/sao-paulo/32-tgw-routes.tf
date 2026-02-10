resource "aws_route" "sp_to_tokyo_via_tgw" {
  route_table_id         = aws_route_table.dawgs_private_rt01.id
  destination_cidr_block = "10.180.0.0/16"
  transit_gateway_id     = aws_ec2_transit_gateway.tgw_sp.id
}