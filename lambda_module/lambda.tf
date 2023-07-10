data "archive_file" "create_lambdacode_zip"{
    type = "zip"
    source_dir = var.path_to_lambda_files
    output_path = var.lambdacode_zip
}

# Lambda function
resource "aws_lambda_function" "lambda_function"{
    function_name = var.function_name
    filename = var.lambdacode_zip
    role = var.role_arn
    handler = var.function_handler
    runtime = "python3.10"
    source_code_hash = data.archive_file.create_lambdacode_zip.output_md5

    depends_on = [ data.archive_file.create_lambdacode_zip ]
}


output lambdafunction_name {
    value = aws_lambda_function.lambda_function.function_name
}

output lambdafunction_arn {
    value = aws_lambda_function.lambda_function.arn
}