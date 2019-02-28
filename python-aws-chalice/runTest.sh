#!bin/bash
cd /var/task
if aws lambda list-functions --region us-east-2 | grep "python_chalice_lambda_regression_test-dev"; then
    zip -r rookout_lambda_test.zip app.py ; \
    aws lambda update-function-code \
                --function-name python_chalice_lambda_regression_test-dev \
                --zip-file fileb:///rookout_lambda_test.zip \
                --region us-east-2 

else
    declare RESULT=($(chalice deploy)) ; \
    for i in “${array[@]}” do echo " " + %i done 
    aws lambda update-function-configuration \
                --function-name python_chalice_lambda_regression_test-dev \
                --region us-east-2 \
                --environment Variables="{ROOKOUT_TOKEN=$ROOKOUT_TOKEN,ROOKOUT_ROOK_TAGS=python_chalice_lambda_regression_test-dev,ROOKOUT_DEBUG=1,ROOKOUT_LOG_TO_STDERR=1}" 
    sleep 20
    curl ${RESULT[26]}
    aws lambda delete-function --region us-east-2 --function-name python_chalice_lambda_regression_test-dev
fi
