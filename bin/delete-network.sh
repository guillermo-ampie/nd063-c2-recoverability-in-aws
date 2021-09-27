#!/bin/bash

PRIMARY_STACK_NAME="primary-vpc-stack"
SECONDARY_STACK_NAME="secondary-vpc-stack"
PRIMARY_REGION="us-west-1"
SECONDARY_REGION="us-east-1"

aws --region ${PRIMARY_REGION} cloudformation delete-stack --stack-name ${PRIMARY_STACK_NAME}
aws --region ${SECONDARY_REGION} cloudformation delete-stack --stack-name ${SECONDARY_STACK_NAME}
