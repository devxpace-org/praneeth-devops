terraform {
  backend "s3" {
    bucket = "terraform-pkrk"
    key    = "tf-state/tf2-backend"
    region = "us-east-1"
  }
}