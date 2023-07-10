variable function_name {}
variable role_arn {}
variable function_handler {}

variable "path_to_lambda_files"{
    default = "lambda_files/"
}
variable "lambdacode_zip"{
    default = "lambda_module/lambdacode.zip"
}