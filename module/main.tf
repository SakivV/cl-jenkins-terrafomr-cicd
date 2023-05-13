
resource "aws_cloudfront_origin_access_identity" "app_oai" {
  comment = "OAI for cloudfront"
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = aws_s3_bucket.s3_bucket.bucket_regional_domain_name
    origin_id = aws_s3_bucket.s3_bucket.id
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.app_oai.cloudfront_access_identity_path
    }
  }
  enabled             = true
  default_root_object = "index.html"
  default_cache_behavior {
    viewer_protocol_policy = "redirect-to-https"
    compress = true
    allowed_methods  = [ "GET", "HEAD","OPTIONS"]
    cached_methods   = ["GET", "HEAD","OPTIONS"]
    target_origin_id = aws_s3_bucket.s3_bucket.id
    forwarded_values {
      headers      = []
      query_string = true
      cookies {
        forward = "all"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
  tags = {
    Environment = var.env
    Terraform = "True"
  }
  viewer_certificate {
    cloudfront_default_certificate = true
  }
}

data "aws_iam_policy_document" "s3_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.s3_bucket.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.app_oai.iam_arn]
    }
  }
  depends_on = [
    aws_s3_bucket.s3_bucket,
    aws_cloudfront_origin_access_identity.app_oai
  ]
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.s3_bucket.id
  policy = data.aws_iam_policy_document.s3_policy.json
}

resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.bucket_name
  acl    = "private"
  website {
    index_document = "index.html"
    error_document = "error.html"
  }
  force_destroy = true
}