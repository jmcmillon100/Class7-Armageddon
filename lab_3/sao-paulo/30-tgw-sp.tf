############################################
# Transit Gateway (São Paulo) + VPC Attachment
############################################

resource "aws_ec2_transit_gateway" "tgw_sp" {
  description = "${var.project_name}-tgw-sp"
  tags        = { Name = "${var.project_name}-tgw-sp" }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "tgw_attach_sp" {
  transit_gateway_id = aws_ec2_transit_gateway.tgw_sp.id
  vpc_id             = aws_vpc.dawgs_vpc01.id
  subnet_ids         = aws_subnet.dawgs_private_subnets[*].id

  tags = { Name = "${var.project_name}-tgw-attach-sp" }
}

output "sp_tgw_id" {
  value = aws_ec2_transit_gateway.tgw_sp.id
}

############################################
# Accept TGW Peering (São Paulo)
############################################

variable "tokyo_tgw_peering_attachment_id" {
  type        = string
  description = "Peering attachment ID created in Tokyo"
}

resource "aws_ec2_transit_gateway_peering_attachment_accepter" "tgw_peer_accept_sp" {
  transit_gateway_attachment_id = var.tokyo_tgw_peering_attachment_id

  lifecycle {
    prevent_destroy = false
  }

  tags = {
    Name = "${var.project_name}-tgw-peer-accept-from-tokyo"
  }
}