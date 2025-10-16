terraform {
  backend "s3" {
    bucket         = "terraform-backned-bucket-756"
    key            = "reactapp/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}

