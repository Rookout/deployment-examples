if aws lambda list-functions --region us-east-2 | grep "node_aws_lambda_regression_test"; then
aws lambda update-function-code \
            --function-name node_aws_lambda_regression_test \
            --zip-file fileb:///../../rookout_lambda_test.zip \
            --region us-east-2 ; \
 
else
aws lambda create-function \
            --region us-east-2 \
            --function-name node_aws_lambda_regression_test \
            --zip-file fileb:///../../rookout_lambda_test.zip \
            --role arn:aws:iam::032275105219:role/rookout-lambda-role \
            --handler index.handler \
            --runtime nodejs8.10 \
            --environment Variables="{ROOKOUT_TOKEN=$ROOKOUT_TOKEN,ROOKOUT_ROOK_TAGS=node_aws_lambda_regression_test,ROOKOUT_LOG_TO_STDERR=1,ROOKOUT_DEBUG=1a}" \
            --timeout 25 \
            --tags "type=regression_test" ; \
fi
