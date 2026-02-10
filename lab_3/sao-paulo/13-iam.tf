############################################
# Least-Privilege IAM (BONUS A)
############################################

# Explanation: dawgs doesn’t hand out the Falcon keys—this policy scopes reads to your lab paths only.
resource "aws_iam_policy" "dawgs_leastpriv_read_params01" {
  name        = "${local.name_prefix}-lp-ssm-read01"
  description = "Least-privilege read for SSM Parameter Store under /lab/db/*"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "ReadLabDbParams"
        Effect = "Allow"
        Action = [
          "ssm:GetParameter",
          "ssm:GetParameters",
          "ssm:GetParametersByPath"
        ]
        Resource = [
          "arn:aws:ssm:${data.aws_region.dawgs_region01.name}:${data.aws_caller_identity.dawgs_self01.account_id}:parameter/lab/db/*"
        ]
      }
    ]
  })
}

# Explanation: dawgs only opens *this* vault—GetSecretValue for only your secret (not the whole planet).
resource "aws_iam_policy" "dawgs_leastpriv_read_secret01" {
  count = var.tokyo_db_secret_arn != "" ? 1 : 0

  name = "${var.project_name}-leastpriv-read-secret01"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["secretsmanager:GetSecretValue", "secretsmanager:DescribeSecret"]
        Resource = var.tokyo_db_secret_arn
      }
    ]
  })
}

# Explanation: When the Falcon logs scream, this lets dawgs ship logs to CloudWatch without giving away the Death Star plans.
resource "aws_iam_policy" "dawgs_leastpriv_cwlogs01" {
  name        = "${local.name_prefix}-lp-cwlogs01"
  description = "Least-privilege CloudWatch Logs write for the app log group"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "WriteLogs"
        Effect = "Allow"
        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogStreams"
        ]
        Resource = [
          "${aws_cloudwatch_log_group.dawgs_log_group01.arn}:*"
        ]
      }
    ]
  })
}

# Explanation: Attach the scoped policies—dawgs loves power, but only the safe kind.
resource "aws_iam_role_policy_attachment" "dawgs_attach_lp_params01" {
  role       = aws_iam_role.dawgs_ec2_role01.name
  policy_arn = aws_iam_policy.dawgs_leastpriv_read_params01.arn
}

resource "aws_iam_role_policy_attachment" "dawgs_attach_lp_secret01" {
  count      = var.tokyo_db_secret_arn != "" ? 1 : 0
  role       = aws_iam_role.dawgs_ec2_role01.name
  policy_arn = aws_iam_policy.dawgs_leastpriv_read_secret01[0].arn
}

resource "aws_iam_role_policy_attachment" "dawgs_attach_lp_cwlogs01" {
  role       = aws_iam_role.dawgs_ec2_role01.name
  policy_arn = aws_iam_policy.dawgs_leastpriv_cwlogs01.arn
}