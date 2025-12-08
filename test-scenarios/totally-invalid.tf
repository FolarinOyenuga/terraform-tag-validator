# ❌ INVALID: No tags at all
resource "aws_s3_bucket" "no_tags" {
  bucket = "no-tags-bucket-${formatdate("YYYYMMDDhhmmss", timestamp())}"
  # No tags block at all!
}

# ❌ INVALID: Only Name tag, missing all required tags
resource "aws_s3_bucket" "only_name" {
  bucket = "only-name-bucket-${formatdate("YYYYMMDDhhmmss", timestamp())}"

  tags = {
    Name = "My Bucket"
    # Missing all required tags
  }
}

# ❌ INVALID: Invalid is-production value
resource "aws_dynamodb_table" "invalid_is_production" {
  name         = "invalid-prod-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }

  tags = {
    business-unit = "HMPPS"
    application   = "Data Storage"
    owner         = "Team: team@test.com"
    is-production = "yes"  # Invalid! Should be "true" or "false"
    service-area  = "Testing"
  }
}

# ❌ INVALID: Mix of empty, missing, and invalid values
resource "aws_lambda_function" "disaster" {
  filename      = "lambda.zip"
  function_name = "disaster-lambda"
  role          = "arn:aws:iam::123456789012:role/lambda-role"
  handler       = "index.handler"
  runtime       = "python3.12"

  tags = {
    business-unit = "WrongUnit"  # Invalid value
    application   = ""            # Empty value
    # owner missing completely
    is-production = "maybe"       # Invalid value
    service-area  = "   "         # Whitespace only
  }
}

# ❌ INVALID: All empty values
resource "aws_kms_key" "all_empty" {
  description = "KMS key with empty tags"

  tags = {
    business-unit = ""
    application   = ""
    owner         = ""
    is-production = ""
    service-area  = ""
  }
}

# ❌ INVALID: No required tags, only random tags
resource "aws_vpc" "random_tags" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name        = "My VPC"
    Environment = "dev"
    Team        = "Platform"
    # No required tags at all
  }
}
