variable sns_topic_name {}
variable "access_policy_file" { default = "sns_module/access_policy.json" }
variable delivery_policy_file { default = "sns_module/delivery_policy.json" }
variable "kms_master_key_id" { default = "alias/aws/sns" }

# Subscription variables
variable "endpoint" {}