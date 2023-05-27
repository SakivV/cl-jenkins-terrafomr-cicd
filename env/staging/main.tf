# module "s3-static-website" {
#   source = "../../module/"
#   bucket_name  = join("-",[var.env,"staticwebsite-iamaws"])
# }

# resource "aws_s3_object" "object" {
#   bucket = module.s3-static-website.s3_bucket_id
#   key    = "index.html"
#   content_type = "text/html"
#   source = "./html/index.html"
# }
