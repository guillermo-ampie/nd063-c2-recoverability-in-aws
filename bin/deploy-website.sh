#!/bin/bash

CLOUDFORMATION_FILE="bucket.yaml"
DIR="cloudformation"
CONTENT_DIR="s3"
BUCKET="bucket-recoverability-010203"
CLOUDFORMATION_STACK_FILE=${DIR}/${CLOUDFORMATION_FILE}
STACK_NAME="static-website-stack"
REGION="us-west-1"
TAGS="project=aws-recoverability"

if aws cloudformation validate-template --template-body file://${CLOUDFORMATION_STACK_FILE} >/dev/null; then
    echo "Deploying stack: ${STACK_NAME} in region: ${REGION}..."
    aws --region ${REGION} cloudformation deploy \
        --template-file ${CLOUDFORMATION_STACK_FILE} \
        --stack-name ${STACK_NAME} \
        --parameter-overrides \
        BUCKETNAME=${BUCKET} \
        --tags ${TAGS}

    echo "Copying files to bucket: S3://${BUCKET}"
    aws s3 cp --recursive ./${CONTENT_DIR} s3://${BUCKET}
fi
