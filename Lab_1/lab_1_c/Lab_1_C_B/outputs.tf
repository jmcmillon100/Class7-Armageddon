# Explanation: Outputs are your mission report—what got built and where to find it.
output "dawgs_vpc_id" {
  value = aws_vpc.dawgs_vpc01.id
}

output "dawgs_public_subnet_ids" {
  value = aws_subnet.dawgs_public_subnets[*].id
}

output "dawgs_private_subnet_ids" {
  value = aws_subnet.dawgs_private_subnets[*].id
}

output "dawgs_ec2_instance_id" {
  value = aws_instance.dawgs_ec201.id
}

output "dawgs_rds_endpoint" {
  value = aws_db_instance.dawgs_rds01.address
}

output "dawgs_sns_topic_arn" {
  value = aws_sns_topic.dawgs_sns_topic01.arn
}

output "dawgs_log_group_name" {
  value = aws_cloudwatch_log_group.dawgs_log_group01.name
}
