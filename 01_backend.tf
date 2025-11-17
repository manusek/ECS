terraform {
  backend "s3" {
    bucket         = "amzn-s3-bucket-tfstate"
    key            = "terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-state-lock"

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
  }
}