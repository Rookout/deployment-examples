if aws lambda list-functions --region us-east-2 | grep "python_chalice_lambda_regression_test"; then
    zip -r rookout_lambda_test.zip app.py ; \
    aws lambda update-function-code \
                --function-name python_chalice_lambda_regression_test \
                --zip-file fileb:///rookout_lambda_test.zip \
                --region us-east-2 \

else
    chalice deploy ; \
    aws lambda update-function-configuration \
                --function-name python_chalice_lambda_regression_test-dev \
                --region us-east-2 \
                --environment Variables="{ROOKOUT_TOKEN=$ROOKOUT_TOKEN,ROOKOUT_ROOK_TAGS=python_lambda_regression_test,ROOKOUT_DEBUG=1,ROOKOUT_LOG_TO_STDERR=1}"
fi
