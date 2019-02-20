#!/bin/bash            
aws lambda invoke --region us-east-2 --function-name java_aws_lambda_test --environment Variables="{ROOKOUT_TOKEN=$ROOKOUT_TOKEN,ROOKOUT_ROOK_TAGS=lambda}" /dev/stdout ; \
aws lambda delete-function --region us-east-2 --function-name java_aws_lambda_test 