terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.66.1"
    }
  }
}

provider "aws" {
  region = var.region
}


locals {
  website_files = fileset(var.website_root, "**")
  mime_types    = jsondecode(file("mime.json"))
  s3_origin_id  = "myS3Origin"
}




