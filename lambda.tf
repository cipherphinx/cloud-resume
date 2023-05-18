
# Creating the IAM role for lambda
resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

# Creating the iam policy document
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

# Creating the cloudwatch log group for lambda
resource "aws_cloudwatch_log_group" "cloudwatch_log_group" {
  name              = "/aws/lambda/${var.lambda_function_name}"
  retention_in_days = 14
}

# Writing the IAM policy document for the lambda basic execution role
data "aws_iam_policy_document" "lambda_logging_execution_policy" {
  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = ["arn:aws:logs:*:*:*"]
  }

  statement {
    effect = "Allow"

    actions = ["dynamodb:*"]

    resources = ["*"]
  }
}

# Creating the IAM policy
resource "aws_iam_policy" "lambda_role" {
  name        = "lambda_logging"
  path        = "/"
  description = "IAM policy for logging from a lambda"
  policy      = data.aws_iam_policy_document.lambda_logging_execution_policy.json
}

# Attaching the policy to the lambda function
resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.lambda_role.arn
}

/*
data "archive_file" "lambda" {
  type        = "zip"
  source_file = "lambda_function.py"
  output_path = "lambda_function_payload.zip"
}
*/

# Creating the lambda function
resource "aws_lambda_function" "get_visitor_count_function" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename      = "lambda_function_payload.zip"
  function_name = var.lambda_function_name
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "lambda_function.lambda_handler"

  source_code_hash = filebase64sha256("artifact/lambda_function_payload.zip")

  runtime = "python3.10"

  environment {
    variables = {
      TABLE_NAME = "visit_count"
    }
  }
}
