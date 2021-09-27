#!/bin/bash

CLOUDFORMATION_FILE="vpc.yaml"
DIR="cloudformation"
CLOUDFORMATION_STACK_FILE=${DIR}/${CLOUDFORMATION_FILE}
PRIMARY_STACK_NAME="primary-vpc-stack"
SECONDARY_STACK_NAME="secondary-vpc-stack"
PRIMARY_REGION="us-west-1"
SECONDARY_REGION="us-east-1"
TAGS="project=aws-recoverability"

if aws cloudformation validate-template --template-body file://${CLOUDFORMATION_STACK_FILE} >/dev/null; then
    echo "Deploying stack: ${PRIMARY_STACK_NAME}..."
    aws --region ${PRIMARY_REGION} cloudformation deploy \
        --template-file ${CLOUDFORMATION_STACK_FILE} \
        --stack-name "${PRIMARY_STACK_NAME}" \
        --parameter-overrides \
        VpcName="Primary" \
        VpcCIDR="10.1.0.0/16" \
        PublicSubnet1CIDR="10.1.10.0/24" \
        PublicSubnet2CIDR="10.1.11.0/24" \
        PrivateSubnet1CIDR="10.1.20.0/24" \
        PrivateSubnet2CIDR="10.1.21.0/24" \
        --tags ${TAGS}

    echo "Deploying stack: ${SECONDARY_STACK_NAME}..."
    aws --region ${SECONDARY_REGION} cloudformation deploy \
        --template-file ${CLOUDFORMATION_STACK_FILE} \
        --stack-name "${SECONDARY_STACK_NAME}" \
        --parameter-overrides \
        VpcName="Secondary" \
        VpcCIDR="10.10.0.0/16" \
        PublicSubnet1CIDR="10.10.10.0/24" \
        PublicSubnet2CIDR="10.10.11.0/24" \
        PrivateSubnet1CIDR="10.10.20.0/24" \
        PrivateSubnet2CIDR="10.10.21.0/24" \
        --tags ${TAGS}
else
    echo
    echo ">>> The template [${CLOUDFORMATION_STACK_FILE}] has some errors, process aborted!!! <<<"
    echo
fi
