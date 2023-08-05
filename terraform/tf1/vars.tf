variable "REGION" {
  default = "us-east-1"
}

variable "ZONE1" {
  default = "us-east-1a"
}

variable "AMIS" {
  type = map(any)
  default = {
    us-east-1 = "ami-09988af04120b3591"
    us-east-2 = "ami-0d1c47ab964ae2b87"
  }
}