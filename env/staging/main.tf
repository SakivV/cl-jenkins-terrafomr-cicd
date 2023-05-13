module "s3-static-website" {
  source = "../../module/"
  bucket_name  = "staging-static-website-iamvivek"
}

module "s3-static-website-test" {
  source = "../../module/"
  bucket_name  = "staging-static-website-iamvishal"
}
