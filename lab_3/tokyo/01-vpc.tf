resource "aws_vpc" "dawgs_vpc01" {
  cidr_block           = "10.180.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${local.name_prefix}-vpc01"
  }
}

############################################
# VPC Endpoint - S3 (Gateway)
############################################

# Explanation: S3 is the supply depot—without this, your private world starves (updates, artifacts, logs).
resource "aws_vpc_endpoint" "dawgs_vpce_s3_gw01" {
  vpc_id            = aws_vpc.dawgs_vpc01.id
  service_name      = "com.amazonaws.${data.aws_region.dawgs_region01.name}.s3"
  vpc_endpoint_type = "Gateway"

  route_table_ids = [
    aws_route_table.dawgs_private_rt01.id
  ]

  tags = {
    Name = "${local.name_prefix}-vpce-s3-gw01"
  }
}

############################################
# VPC Endpoints - SSM (Interface)
############################################

# Explanation: SSM is your Force choke—remote control without SSH, and nobody sees your keys.
resource "aws_vpc_endpoint" "dawgs_vpce_ssm01" {
  vpc_id              = aws_vpc.dawgs_vpc01.id
  service_name        = "com.amazonaws.${data.aws_region.dawgs_region01.name}.ssm"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  subnet_ids         = aws_subnet.dawgs_private_subnets[*].id
  security_group_ids = [aws_security_group.dawgs_vpce_sg01.id]

  tags = {
    Name = "${local.name_prefix}-vpce-ssm01"
  }
}

# Explanation: ec2messages is the Wookiee messenger—SSM sessions won’t work without it.
resource "aws_vpc_endpoint" "dawgs_vpce_ec2messages01" {
  vpc_id              = aws_vpc.dawgs_vpc01.id
  service_name        = "com.amazonaws.${data.aws_region.dawgs_region01.name}.ec2messages"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  subnet_ids         = aws_subnet.dawgs_private_subnets[*].id
  security_group_ids = [aws_security_group.dawgs_vpce_sg01.id]

  tags = {
    Name = "${local.name_prefix}-vpce-ec2messages01"
  }
}

# Explanation: ssmmessages is the holonet channel—Session Manager needs it to talk back.
resource "aws_vpc_endpoint" "dawgs_vpce_ssmmessages01" {
  vpc_id              = aws_vpc.dawgs_vpc01.id
  service_name        = "com.amazonaws.${data.aws_region.dawgs_region01.name}.ssmmessages"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  subnet_ids         = aws_subnet.dawgs_private_subnets[*].id
  security_group_ids = [aws_security_group.dawgs_vpce_sg01.id]

  tags = {
    Name = "${local.name_prefix}-vpce-ssmmessages01"
  }
}

############################################
# VPC Endpoint - CloudWatch Logs (Interface)
############################################

# Explanation: CloudWatch Logs is the ship’s black box—dawgs wants crash data, always.
resource "aws_vpc_endpoint" "dawgs_vpce_logs01" {
  vpc_id              = aws_vpc.dawgs_vpc01.id
  service_name        = "com.amazonaws.${data.aws_region.dawgs_region01.name}.logs"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  subnet_ids         = aws_subnet.dawgs_private_subnets[*].id
  security_group_ids = [aws_security_group.dawgs_vpce_sg01.id]

  tags = {
    Name = "${local.name_prefix}-vpce-logs01"
  }
}

############################################
# VPC Endpoint - Secrets Manager (Interface)
############################################

# Explanation: Secrets Manager is the locked vault—dawgs doesn’t put passwords on sticky notes.
resource "aws_vpc_endpoint" "dawgs_vpce_secrets01" {
  vpc_id              = aws_vpc.dawgs_vpc01.id
  service_name        = "com.amazonaws.${data.aws_region.dawgs_region01.name}.secretsmanager"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  subnet_ids         = aws_subnet.dawgs_private_subnets[*].id
  security_group_ids = [aws_security_group.dawgs_vpce_sg01.id]

  tags = {
    Name = "${local.name_prefix}-vpce-secrets01"
  }
}

############################################
# Optional: VPC Endpoint - KMS (Interface)
############################################

# Explanation: KMS is the encryption kyber crystal—dawgs prefers locked doors AND locked safes.
resource "aws_vpc_endpoint" "dawgs_vpce_kms01" {
  vpc_id              = aws_vpc.dawgs_vpc01.id
  service_name        = "com.amazonaws.${data.aws_region.dawgs_region01.name}.kms"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  subnet_ids         = aws_subnet.dawgs_private_subnets[*].id
  security_group_ids = [aws_security_group.dawgs_vpce_sg01.id]

  tags = {
    Name = "${local.name_prefix}-vpce-kms01"
  }
}