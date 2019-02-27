#!/bin/bash
if aws lambda list-functions --region us-east-2 | grep "java_aws_lambda_test"; then
aws lambda update-function-code \
            --function-name java_aws_lambda_test \
            --zip-file fileb:///aws-lambda-java-1.0-SNAPSHOT.zip \
            --region us-east-2 \

else
aws lambda create-function \
            --region us-east-2 \
            --function-name java_aws_lambda_test \
            --zip-file fileb:///aws-lambda-java-1.0-SNAPSHOT.zip \
            --role arn:aws:iam::032275105219:role/rookout-lambda-role \
            --handler TestLambda.TestLambda::handleRequest \
            --runtime java8 \
	    --timeout 25 \
	    --memory-size 400 \
            --environment Variables="{ROOKOUT_TOKEN=$ROOKOUT_TOKEN,ROOKOUT_ROOK_TAGS=java_aws_lambda_test,ROOKOUT_DEBUG=1,ROOKOUT_LOG_TO_STDERR=1}" ; \
fi
