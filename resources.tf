data "aws_caller_identity" "current" {}

resource "aws_cloudtrail" "wassha_cloudtrail" {
  name                          = "tf-trail-foobar"
  s3_bucket_name                = aws_s3_bucket.wassha_cloudtrail_s3_bucket.id
  s3_key_prefix                 = "prefix"
  include_global_service_events = false
}

resource "aws_s3_bucket" "wassha_cloudtrail_s3_bucket" {
  bucket = "wassha-cloudtrail-s3-bucket"
  tags = {
    Name        = "Wassha Cloudtrail S3 Buckket"
    Environment = "Dev"
  }
}

data "aws_iam_policy_document" "wassha_cloudtrail_policy_data" {
  statement {
    sid    = "AWSCloudTrailAclCheck"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }

    actions   = ["s3:GetBucketAcl"]
    resources = [aws_s3_bucket.wassha_cloudtrail_s3_bucket.arn]
  }

  statement {
    sid    = "AWSCloudTrailWrite"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }

    actions   = ["s3:PutObject"]
    resources = ["${aws_s3_bucket.wassha_cloudtrail_s3_bucket.arn}/prefix/AWSLogs/${data.aws_caller_identity.current.account_id}/*"]

    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
  }
}

resource "aws_s3_bucket_policy" "wassha_cloudtrail_policy" {
  bucket = aws_s3_bucket.wassha_cloudtrail_s3_bucket.id
  policy = data.aws_iam_policy_document.wassha_cloudtrail_policy_data.json
}