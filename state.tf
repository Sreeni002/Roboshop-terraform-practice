terraform {
  backend "S3" {
    bucket = "terraform-practice-roboshop"
    key = "roboshop/test/terraform.tfstate"
    region = "us-east-1"
  }
}