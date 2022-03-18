terraform {
  backend "s3" {
    bucket         = "cf-templates-11x1qjid1uaq7-us-east-1"
    key            = "dev-rookout/rookout"
    region         = "us-east-1"
    dynamodb_table = "dev-terraform-state-lock"
  }
}

# aws dynamodb create-table --table-name dev-terraform-state-lock --attribute-definitions AttributeName=LockID,AttributeType=S --key-schema AttributeName=LockID,KeyType=HASH --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5