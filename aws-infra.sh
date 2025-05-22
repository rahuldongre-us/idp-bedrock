#!/bin/bash

# Exit on error
set -e

# Variables
############################
LAMBDA_FILE="idp_lambda_processor.py"
ZIP_FILE="lambda_function_payload.zip"
############################

cd ./code

# Step 1: Zip the Lambda function
echo "📦 Zipping Lambda function..."
if [ -f "$ZIP_FILE" ]; then
  rm "$ZIP_FILE"
fi
zip ../"$ZIP_FILE" *

cd ../infra

# Step 2: Initialize Terraform
echo "🚀 Initializing Terraform..."
terraform init

# Step 3: Plan Terraform changes
echo "🔍 Planning infrastructure..."
terraform plan -out=tfplan-idp

# Step 4: Apply the Terraform plan
echo "✅ Applying changes..."
terraform apply tfplan-idp

