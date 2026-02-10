############################################
# Transit Gateway (Tokyo) + VPC Attachment
############################################

resource "aws_ec2_transit_gateway" "tgw_tokyo" {
  description = "${var.project_name}-tgw-tokyo"
  tags        = { Name = "${var.project_name}-tgw-tokyo" }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "tgw_attach_tokyo" {
  transit_gateway_id = aws_ec2_transit_gateway.tgw_tokyo.id
  vpc_id             = aws_vpc.dawgs_vpc01.id
  subnet_ids         = aws_subnet.dawgs_private_subnets[*].id

  tags = { Name = "${var.project_name}-tgw-attach-tokyo" }
}

output "tokyo_tgw_id" {
  value = aws_ec2_transit_gateway.tgw_tokyo.id
}

############################################
# TGW Peering (Tokyo -> São Paulo)
############################################

resource "aws_ec2_transit_gateway_peering_attachment" "tgw_peer_tokyo_to_sp" {
  transit_gateway_id      = aws_ec2_transit_gateway.tgw_tokyo.id
  peer_transit_gateway_id = "tgw-00cc78cfe4c7ed33a"
  peer_region             = "sa-east-1"

  tags = {
    Name = "${var.project_name}-tgw-peer-to-sp"
  }
}

output "tokyo_tgw_peering_attachment_id" {
  value = aws_ec2_transit_gateway_peering_attachment.tgw_peer_tokyo_to_sp.id
}