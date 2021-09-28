#!/bin/bash

STACK_NAME="static-website-stack"
REGION="us-west-1"
BUCKET="bucket-recoverability-010203"

#https://stackoverflow.com/questions/29809105/how-do-i-delete-a-versioned-bucket-in-aws-s3-using-the-cli
aws s3api delete-objects --bucket ${BUCKET} --delete "$(aws s3api list-object-versions \
    --bucket ${BUCKET} --output=json --query='{Objects: *[].{Key:Key,VersionId:VersionId}}')"

aws --region ${REGION} cloudformation delete-stack --stack-name ${STACK_NAME}
