resource "aws_cloudwatch_event_rule" "trigger_event"{
    name = var.trigger_event_name
    description = "cloudwatch trigger event for lambdafunction"
    role_arn = var.cloudwatchevent_role_arn
    schedule_expression = var.schedule_cron_expression
}

resource "aws_lambda_permission" "allow_cloudwatch" {
    statement_id  = "AllowExecutionFromCloudWatch"
    action        = "lambda:InvokeFunction"
    function_name = var.lambdafunction_name
    principal     = "events.amazonaws.com"
    source_arn    = aws_cloudwatch_event_rule.trigger_event.arn
    #qualifier     = aws_lambda_alias.test_alias.name
}

resource "aws_cloudwatch_event_target" "link_event_and_pipeline"{
    target_id = "lambda-target"
    rule = aws_cloudwatch_event_rule.trigger_event.name
    arn = var.lambdafunction_arn
}