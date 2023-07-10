# Do not pass values here. Pass your values in terraform.tfvars file

# IAM VARS
variable cloudwatchevent_role_name {}
variable cloudwatchevent_policy_name {}
variable lambdafunction_role_name {}
variable lambdafunction_policy_name {}
variable vpn_lambda_policy_arn {}

# Lambda VARS
variable function_name {}
variable function_handler {}

# CloudWatch-Event VARS
variable trigger_event_name {}
variable schedule_cron_expression {}

# s3 VARS
variable s3_bucket_name {}

# SNS VARS
variable sns_topic_name {}
# subscription variables
variable "endpoint" {}