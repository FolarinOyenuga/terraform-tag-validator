terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region                      = "eu-west-2"
  skip_credentials_validation = true
  skip_requesting_account_id  = true
  skip_metadata_api_check     = true
  
  access_key = "test"
  secret_key = "test"
}

# ✅ S3 bucket with ALL required tags
resource "aws_s3_bucket" "fully_compliant" {
  bucket = "fully-compliant-bucket-${formatdate("YYYYMMDDhhmmss", timestamp())}"

  tags = {
    business-unit = "Platforms"
    application   = "Tag Enforcement Testing"
    owner         = "COAT Team: coat@digital.justice.gov.uk"
    is-production = "false"
    service-area  = "Cloud Optimisation"
    Name          = "Fully Compliant Bucket"
  }
}

# ✅ DynamoDB table with ALL required tags
resource "aws_dynamodb_table" "fully_compliant" {
  name         = "fully-compliant-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }

  tags = {
    business-unit = "HMPPS"
    application   = "Data Storage"
    owner         = "Platform Team: platform@digital.justice.gov.uk"
    is-production = "true"
    service-area  = "Prisons"
  }
}

# ✅ Lambda function with ALL required tags
resource "aws_lambda_function" "fully_compliant" {
  filename      = "lambda.zip"
  function_name = "fully-compliant-function"
  role          = "arn:aws:iam::123456789012:role/lambda-role"
  handler       = "index.handler"
  runtime       = "python3.12"

  tags = {
    business-unit = "LAA"
    application   = "Document Processing"
    owner         = "Legal Aid Team: laa@digital.justice.gov.uk"
    is-production = "false"
    service-area  = "Legal Services"
  }
}
