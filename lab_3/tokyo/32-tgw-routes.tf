resource "aws_route" "tokyo_to_sp_via_tgw" {
  route_table_id         = aws_route_table.dawgs_private_rt01.id
  destination_cidr_block = "10.181.0.0/16"
  transit_gateway_id     = aws_ec2_transit_gateway.tgw_tokyo.id
}
