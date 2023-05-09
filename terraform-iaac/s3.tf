// Creating the bucket
resource "aws_s3_bucket" "s3-resume-bucket" {
  bucket = var.BUCKET_NAME

  tags = {
    Name = "s3-resume-bucket"
  }
}

// Setting the public access
resource "aws_s3_bucket_public_access_block" "s3-pub-access-block" {
  bucket = aws_s3_bucket.s3-resume-bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

// Configure the bucket for static web hosting
resource "aws_s3_bucket_website_configuration" "s3-resume-bucket-web-config" {
  bucket = aws_s3_bucket.s3-resume-bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

}

// Setting the bucket policy for public access
resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
  bucket = aws_s3_bucket.s3-resume-bucket.id
  policy = data.aws_iam_policy_document.allow_access_from_another_account.json

  depends_on = [aws_s3_bucket_public_access_block.s3-pub-access-block]
}

data "aws_iam_policy_document" "allow_access_from_another_account" {
  statement {
    sid = "publicaccesspolicy"
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    actions = [
      "s3:GetObject"
    ]
    resources = [
      "${aws_s3_bucket.s3-resume-bucket.arn}/*",
    ]
  }
}

// Uploading the html files to the s3 bucket
resource "aws_s3_object" "webfiles" {
  for_each = local.website_files

  bucket       = aws_s3_bucket.s3-resume-bucket.id
  key          = each.key
  source       = "${var.website_root}/${each.key}"
  source_hash  = filemd5("${var.website_root}/${each.key}")
  content_type = lookup(local.mime_types, regex("\\.[^.]+$", each.key), null)
}
