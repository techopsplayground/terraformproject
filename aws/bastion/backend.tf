terraform {
  backend "s3" {
    bucket         = "ms-tfstate-1"  # Replace with your bucket name
    key            = "terraform/state.tfstate"
    region         = "us-west-2"                  # Replace with your region
    encrypt        = true
    dynamodb_table = "my-terraform-lock-table"    # Replace with your DynamoDB table name for locking
    acl            = "private"
  }
}
