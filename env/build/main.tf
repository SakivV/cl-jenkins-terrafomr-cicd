module "s3-static-website" {
  source = "../../module/"
  bucket_name  = join("-",["build","staticwebsite-iamaws"])
}

resource "aws_s3_object" "object" {
  bucket = module.s3-static-website.s3_bucket_id
  key    = "index.html"
  source = "./html/index.html"
}
