#!/bin/bash

# Set the region
REGION="us-east-1"

# Set the name of the RDS cluster
CLUSTER_NAME="my-rds-cluster"

# Set the name of the database
DB_NAME="mydatabase"

# Set the username for the master database user
MASTER_USERNAME="admin"

# Set the password for the master database user
MASTER_PASSWORD="password123"

# Set the port for the RDS cluster
DB_PORT=3306

# Set the node type for the RDS cluster
DB_NODE_TYPE="db.t2.micro"

# Set the number of nodes for the RDS cluster
DB_NUM_NODES=1

# Set the name of the database subnet group
DB_SUBNET_GROUP_NAME="my-rds-subnet-group"

# Set the VPC ID
VPC_ID="vpc-abc123"

# Set the security group ID
SECURITY_GROUP_ID="sg-abc123"

# Set the availability zone
AVAILABILITY_ZONE="us-east-1a"

# Create the RDS cluster
aws rds create-db-cluster \
  --region $REGION \
  --db-cluster-identifier $CLUSTER_NAME \
  --database-name $DB_NAME \
  --master-username $MASTER_USERNAME \
  --master-user-password $MASTER_PASSWORD \
  --port $DB_PORT \
  --db-node-type $DB_NODE_TYPE \
  --number-of-db-nodes $DB_NUM_NODES \
  --db-subnet-group-name $DB_SUBNET_GROUP_NAME \
  --vpc-security-group-ids $SECURITY_GROUP_ID \
  --availability-zones $AVAILABILITY_ZONE
