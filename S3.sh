#!/bin/bash

# Set the region
REGION="us-east-1"

# Set the name of the bucket
BUCKET_NAME="my-s3-bucket"

# Set the access control for the bucket
ACL="private"

# Create the S3 bucket
aws s3api create-bucket \
  --region $REGION \
  --bucket $BUCKET_NAME \
  --acl $ACL
