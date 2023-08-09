provider "aws" {
  region = var.REGION
}

data "aws_availability_zones" "available" {}
data "aws_region" "current" {}