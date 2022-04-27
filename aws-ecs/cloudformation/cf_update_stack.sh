#!/bin/bash
# Usage: ENV_NAME=<env> ./cf_update_stack.sh <cf operation create/update>
# Stack will be updated by default.
# i.e.: ./cf_update_stack.sh create

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
TEMPLATES_PATH=$SCRIPTPATH/templates
source $SCRIPTPATH/set_env.sh

ENV_NAME=${ENV_NAME:-'dev'}
OPERATION=${1:-"update"}
STACK_TYPE=${2:-"rookout"}

case $STACK_TYPE in

  master)
    TEMPLATE_FILE="master.yaml"
    ;;

  rookout)
    TEMPLATE_FILE="rookout-aws-ecs.yaml"
    ;;

  *)
    TEMPLATE_FILE="rookout-aws-ecs.yaml"
    ;;
esac

aws s3 cp --recursive --exclude "*" --include "*.yaml" --include "*.json" \
          $TEMPLATES_PATH s3://${S3_BUCKET}/${S3_PREFIX}/

if [[ "$OPERATION" == "delete" ]]; then
    aws cloudformation ${OPERATION}-stack \
        --stack-name $STACK_NAME
else
    aws cloudformation ${OPERATION}-stack \
        --stack-name $STACK_NAME \
        --template-url https://s3.amazonaws.com/${S3_BUCKET}/${S3_PREFIX}/${TEMPLATE_FILE} \
        --capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM \
        --parameters file://${STACK_TYPE}.${ENV_NAME}.json
fi

echo Waiting for stack $OPERATION completion...
echo You could safely interrupt it. It will not impact stack.

aws cloudformation wait stack-${OPERATION}-complete \
    --stack-name $STACK_NAME
