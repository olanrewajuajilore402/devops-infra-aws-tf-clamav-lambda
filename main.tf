module "iam_module"{
    source = "./iam_module"
    cloudwatchevent_role_name = var.cloudwatchevent_role_name
    cloudwatchevent_policy_name = var.cloudwatchevent_policy_name
    lambdafunction_role_name = var.lambdafunction_role_name
    lambdafunction_policy_name = var.lambdafunction_policy_name
    vpn_lambda_policy_arn = var.vpn_lambda_policy_arn
}

module "lambda_module"{
    source = "./lambda_module"
    function_name = var.function_name
    function_handler = var.function_handler
    role_arn = module.iam_module.lambdarole_arn
}

module "cloudwatch_module"{
    source = "./cloudwatch_module"
    trigger_event_name = var.trigger_event_name
    schedule_cron_expression = var.schedule_cron_expression
    cloudwatchevent_role_arn = module.iam_module.cloudwatchevent_role_arn
    lambdafunction_name = module.lambda_module.lambdafunction_name
    lambdafunction_arn = module.lambda_module.lambdafunction_arn
}

module "s3_module"{
    source = "./s3_module"
    s3_bucket_name = var.s3_bucket_name
}

module "sns_module"{
    source = "./sns_module"
    sns_topic_name = var.sns_topic_name
    endpoint = var.endpoint
}