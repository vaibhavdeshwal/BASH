#!/bin/bash

# Set the region
REGION="us-east-1"

# Set the AMI ID
AMI_ID="ami-01234567890abcdef"

# Set the instance type
INSTANCE_TYPE="t2.micro"

# Set the name of the key pair
KEY_NAME="my-key-pair"

# Set the security group ID
SECURITY_GROUP_ID="sg-01234567890abcdef"

# Set the subnet ID
SUBNET_ID="subnet-01234567890abcdef"

# Set the name of the EC2 instance
INSTANCE_NAME="my-ec2-instance"

# Create the EC2 instance
aws ec2 run-instances \
  --region $REGION \
  --image-id $AMI_ID \
  --instance-type $INSTANCE_TYPE \
  --key-name $KEY_NAME \
  --security-group-ids $SECURITY_GROUP_ID \
  --subnet-id $SUBNET_ID \
  --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value='"$INSTANCE_NAME"'}]'
