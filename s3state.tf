//statefile for remotebackend
terraform {

  backend "s3" {
      bucket = "prefix-fiction"
      key = "sample/terraform-state"
      region = "us-east-1"
      access_key = "AKIA45KFE7XOQ6PAKUFR"
      secret_key = "p0q4VuMT2fDdKKhlc/Ii5fIaegR+XXjAu6okffCD"
  }
}