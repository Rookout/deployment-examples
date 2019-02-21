#!/bin/bash
aws lambda create-function \
            --region us-east-2 \
            --function-name java_aws_lambda_test \
            --zip-file fileb://aws-lambda-java-1.0-SNAPSHOT.zip \
            --role arn:aws:iam::032275105219:role/rookout-lambda-role \
            --handler TestLambda.TestLambda::handleRequest \
            --runtime java8 \
	    --timeout 25 \
	    --memory-size 400 \
            --environment Variables="{ROOKOUT_TOKEN=$ROOKOUT_TOKEN,ROOKOUT_ROOK_TAGS=lambda}" ; \
aws lambda invoke --region us-east-2 --function-name java_aws_lambda_test /dev/stdout ; \
aws lambda delete-function --region us-east-2 --function-name java_aws_lambda_test 