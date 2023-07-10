# IAM Role and policy for cloudwatch event and lambda function

# Cloudwatch event role
resource "aws_iam_role" "cloudwatchevent_role" {
    name = var.cloudwatchevent_role_name

    assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = "invokelambdarole"
        Principal = {
          Service = "events.amazonaws.com"
        }
      },
    ]
  })

  tags = {
      Description = "Cloudwatch event trigger role for Lambda function"
  }
}

# Cloudwatch event policy
resource "aws_iam_policy" "cloudwatchevent_policy" {
    name = var.cloudwatchevent_policy_name
    description = "Policy for invoking lambda function"

    policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Action = [
          "lambda:InvokeFunction"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]

  })
}

# Attach cloudwatch event policy to role
resource "aws_iam_role_policy_attachment" "attach_cloudwatchevent_trigger_policy" {
    role = aws_iam_role.cloudwatchevent_role.name
    policy_arn = aws_iam_policy.cloudwatchevent_policy.arn
}


# Lambda function role
resource "aws_iam_role" "lambdafunction_role" {
    name = var.lambdafunction_role_name

    assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = "lambdaexecutionrole"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })

  tags = {
      Description = "Lambda function role - ${var.lambdafunction_role_name}"
  }
}

# Lambda function policy (s3 and cloudwatch permissions)
resource "aws_iam_policy" "lambdafunction_policy" {
    name = var.lambdafunction_policy_name
    description = "lambda policy - ${var.lambdafunction_policy_name}"

    policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Action = [
          "s3:PutObject",
          "s3:ListObjects",
          "s3:GetObjectVersion",
          "s3:GetObject",
          "s3:GetBucketVersioning",
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]

  })
}

# Attach lambda policy to role
resource "aws_iam_role_policy_attachment" "attach_lambda_policy" {
    role = aws_iam_role.lambdafunction_role.name
    policy_arn = aws_iam_policy.lambdafunction_policy.arn
}


# Attach VPN policy to lambda role
resource "aws_iam_role_policy_attachment" "attach_vpn_policy" {
    for_each = toset([
        "${var.vpn_lambda_policy_arn}",
    ])
    role = aws_iam_role.lambdafunction_role.name
    policy_arn = each.value
}





output cloudwatchevent_role_arn {
    value = aws_iam_role.cloudwatchevent_role.arn
}

output lambdarole_arn {
    value = aws_iam_role.lambdafunction_role.arn
}