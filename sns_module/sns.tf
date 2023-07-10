resource "aws_sns_topic" "standard_sns_topic" {
    name = var.sns_topic_name
    # policy = file(var.access_policy_file)
    # delivery_policy = file(var.delivery_policy_file)
    kms_master_key_id = var.kms_master_key_id
}

resource "aws_sns_topic_subscription" "subsription_for_standard_topic" {
    topic_arn = aws_sns_topic.standard_sns_topic.arn
    protocol = "email"
    endpoint = var.endpoint
}