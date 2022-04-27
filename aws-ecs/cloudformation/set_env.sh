#!/bin/bash

export ENV_NAME=dev
export STACK_NAME=${ENV_NAME}-rookout-example
export ACCOUNT_ID=782824484157
export REGION=us-east-1
export AWS_DEFAULT_REGION=${REGION}

# Bucket details for Cloudformation templates and Lambda
export ENV_NAME=${ENV_NAME:-'dev'}
export S3_BUCKET=cf-templates-11x1qjid1uaq7-us-east-1
export S3_PREFIX=${ENV_NAME}-rookout

if [[ "$0" != "${BASH_SOURCE[0]}" ]]; then
    SCRIPTPATH="$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )"
else
    SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
fi
