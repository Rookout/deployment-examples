if aws lambda list-functions --region us-east-2 | grep "python_lambda_regression_test"; then
aws lambda update-function-code \
            --function-name python_lambda_regression_test \
            --zip-file fileb:///../../rookout_lambda_test.zip \
            --region us-east-2 \

else
aws lambda create-function \
            --region us-east-2 \
            --function-name python_lambda_regression_test \
            --zip-file fileb:///rookout_lambda_test.zip \
            --role arn:aws:iam::032275105219:role/rookout-lambda-role \
            --handler lambda_function.lambda_handler \
            --runtime python2.7 \
            --environment Variables="{ROOKOUT_TOKEN=$ROOKOUT_TOKEN,ROOKOUT_ROOK_TAGS=lambda,ROOKOUT_DEBUG=1,ROOKOUT_LOG_TO_STDERR=1}" \
            --timeout 25 \
            --memory-size 400 ; \
            sleep 10
fi