module "s3-static-website" {
  source = "../../module/"
  bucket_name  = "${var.env}-static-website-iamaws"
}

resource "aws_s3_object" "object" {
  bucket = module.s3-static-website.id
  key    = "index.html"
  source = "./html/"
}
