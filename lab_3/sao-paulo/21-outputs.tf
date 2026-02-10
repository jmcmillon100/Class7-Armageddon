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
  value = aws_instance.dawgs_ec201_private_bonus.id
}

# output "dawgs_rds_endpoint" {
#   value = aws_db_instance.dawgs_rds01.address
# }

output "dawgs_sns_topic_arn" {
  value = aws_sns_topic.dawgs_sns_topic01.arn
}

output "dawgs_log_group_name" {
  value = aws_cloudwatch_log_group.dawgs_log_group01.name
}

output "dawgs_apex_url_https" {
  value = "https://${var.domain_name}"
}

# output "dawgs_alb_logs_bucket_name" {
#   value = var.enable_alb_access_logs ? aws_s3_bucket.dawgs_alb_logs_bucket01[0].bucket : null
# }

output "dawgs_waf_log_destination" {
  value = var.waf_log_destination
}

output "dawgs_waf_logs_s3_bucket" {
  value = var.waf_log_destination == "s3" ? aws_s3_bucket.dawgs_waf_logs_bucket01[0].bucket : null
}

output "sp_vpc_cidr" {
  value = aws_vpc.dawgs_vpc01.cidr_block
}

output "sp_private_route_table_ids" {
  value = [aws_route_table.dawgs_private_rt01.id]
}

output "sp_public_route_table_id" {
  value = aws_route_table.dawgs_public_rt01.id
}