#!/bin/bash

export ENV_NAME=dev
export STACK_NAME=rookout-onprem
export REGION=us-east-1
export AWS_DEFAULT_REGION=${REGION}

# Bucket details for Cloudformation templates
export S3_BUCKET=cf-templates-11x1qjid1uaq7-us-east-1
export S3_PREFIX=$STACK_NAME

if [[ "$0" != "${BASH_SOURCE[0]}" ]]; then
    SCRIPTPATH="$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )"
else
    SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
fi