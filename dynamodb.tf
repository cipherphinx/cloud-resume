resource "aws_dynamodb_table" "visit_count_table" {
  name = "visit_count"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "website"
    type = "S"
  }
  hash_key = "website"
}