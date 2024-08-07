resource "aws_s3_bucket" "bucket" {
  provider = aws.eu_west_1
  bucket   = "www.colby-smith-labs.com"
}

resource "aws_s3_bucket_public_access_block" "bucket_access_block" {
  provider = aws.eu_west_1
  bucket   = aws_s3_bucket.bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  provider = aws.eu_west_1
  depends_on = [aws_s3_bucket_public_access_block.bucket_access_block]
  bucket     = aws_s3_bucket.bucket.id
  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Sid" : "PublicReadGetObject",
          "Effect" : "Allow",
          "Principal" : "*",
          "Action" : "s3:GetObject",
          "Resource" : "arn:aws:s3:::${aws_s3_bucket.bucket.id}/*"
        }
      ]
    }
  )
}

resource "aws_s3_object" "file" {
  provider  = aws.eu_west_1
  for_each   = fileset(path.module, "content/**/*")
  bucket     = aws_s3_bucket.bucket.id
  key        = replace(each.value, "/^content//", "")
  source     = each.value
  content_type = lookup(local.content_types, regex("\\.[^.]+$", each.value), "application/octet-stream")
  source_hash = filemd5(each.value)
}

resource "aws_s3_bucket_website_configuration" "hosting" {
  provider = aws.eu_west_1
  bucket   = aws_s3_bucket.bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "404.html"
  }
}
