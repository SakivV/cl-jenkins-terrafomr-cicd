terraform {
  required_version = "~>1.4.0"
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~>4.45.0"
    }
  }

  backend "s3" {
    bucket = "cloudmagic-build-terraform-state"
    key = "application/prod/class/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform_build_dynamo"
  }

}
provider "aws" {
  region = var.aws_region
  assume_role {
    role_arn    = "arn:aws:iam::781625734165:role/jenkins-cicd-role"
  }
}