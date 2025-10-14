terraform {
  backend "s3" {
    bucket         = "<YOUR_S3_BUCKET>"
    key            = "reactapp/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "<YOUR_DYNAMODB_TABLE>"
    encrypt        = true
  }
}

