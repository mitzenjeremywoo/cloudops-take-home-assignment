resource "aws_s3_bucket" "webapp_bucket" {
  bucket        = var.webapp.bucketname
  force_destroy = true

  tags = {
    Name        = "${var.webapp.bucketname}-bucket"
    Environment = var.webapp.env
  }
}

resource "aws_s3_bucket_ownership_controls" "webapp_control" {
  bucket = aws_s3_bucket.webapp_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "webapp_bucket_acl" {
  depends_on = [aws_s3_bucket.webapp_bucket, aws_s3_bucket_ownership_controls.webapp_control]

  bucket = aws_s3_bucket.webapp_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "app" {
  bucket                  = aws_s3_bucket.webapp_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_cloudtrail" "s3_logging" {

  name                          = "${var.webapp.bucketname}-${var.webapp.env}-ct"
  s3_bucket_name                = aws_s3_bucket.webapp_bucket.id
  s3_key_prefix                 = "prefix"
  include_global_service_events = true

  event_selector {
    read_write_type           = "All"
    include_management_events = true

    data_resource {
      type   = "AWS::S3::Object"
      values = ["${aws_s3_bucket.webapp_bucket.arn}/"]
    }
  }
}